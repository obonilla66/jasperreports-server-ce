/*
 * Copyright (C) 2005 - 2020 TIBCO Software Inc. All rights reserved.
 * http://www.jaspersoft.com.
 *
 * Unless you have purchased a commercial license agreement from Jaspersoft,
 * the following license terms apply:
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
package com.jaspersoft.jasperserver.inputcontrols.cascade.handlers;

import com.jaspersoft.jasperserver.api.engine.common.service.ReportInputControlInformation;
import com.jaspersoft.jasperserver.api.metadata.common.domain.InputControl;
import com.jaspersoft.jasperserver.api.metadata.common.domain.ListOfValuesItem;
import com.jaspersoft.jasperserver.api.metadata.common.domain.ResourceReference;
import com.jaspersoft.jasperserver.inputcontrols.cascade.CascadeResourceNotFoundException;
import com.jaspersoft.jasperserver.inputcontrols.cascade.InputControlValidationException;
import org.apache.commons.lang.StringUtils;

import java.util.*;

import static com.jaspersoft.jasperserver.inputcontrols.cascade.handlers.SingleSelectListInputControlHandler.TOTAL_COUNT;


/**
 * @author Yaroslav.Kovalchyk
 * @version $Id$
 */
public interface ValuesLoader {
    String OUT_OF_RANGE_ERROR = "error.out.of.range";
    String SELECT = "select";
    String LIMIT = "limit";
    String OFFSET = "offset";
    String CRITERIA = "criteria";
    /**
     * load input control state values from either database or cache.
     * @param inputControl
     * @param dataSource
     * @param parameters
     * @param parameterTypes
     * @param info
     * @return
     * @throws CascadeResourceNotFoundException
     */
    List<ListOfValuesItem> loadValues(InputControl inputControl, ResourceReference dataSource, Map<String, Object> parameters, Map<String, Class<?>> parameterTypes, ReportInputControlInformation info, boolean isSingleSelect) throws CascadeResourceNotFoundException;

    /**
     *
     * @param inputControl
     * @param dataSource
     * @return
     * @throws CascadeResourceNotFoundException
     */
    Set<String> getMasterDependencies(InputControl inputControl, ResourceReference dataSource) throws CascadeResourceNotFoundException;

    /**
     * If the limit-offset is provided, filter the results based on the totalLimit
     * and filter by search criteria when provided and then add item to result.
     *
     * @param criteria
     * @param totalLimit
     * @param result
     * @param item
     * @return boolean, which identifies whether the result is within limit.
     */
    default boolean checkLimitAndAddItem(String criteria, int totalLimit, List<ListOfValuesItem> result, ListOfValuesItem item) {
        if(result.size() < totalLimit) {
            checkCriteriaAndAddItem(criteria, result, item);
            return true;
        } else {
            return false;
        }
    }

    /**
     * Filter by search criteria when provided and then add item to result.
     * @param criteria
     * @param result
     * @param item
     * @return InputControlValues
     */
    default List<ListOfValuesItem> checkCriteriaAndAddItem(String criteria, List<ListOfValuesItem> result, ListOfValuesItem item) {
        if(criteria != null && !StringUtils.containsIgnoreCase(item.getLabel(), criteria)) {
            //do nothing when label does not contain criteria
        } else {
            result.add(item);
        }
        return result;
    }

    /**
     * Get criteria from parameters.
     * @param inputControl
     * @param parameters
     * @return criteria
     */
    default String getCriteria(InputControl inputControl, Map<String, Object> parameters) {
        Object criteria = parameters.get(inputControl.getName() +"_"+ CRITERIA);
        if(criteria != null) {
            return (String)criteria;
        } else {
            return null;
        }
    }

    /**
     * Get offset from parameters and validate it.
     * @param inputControl
     * @param parameters
     * @param size
     * @return offset
     */
    default int getOffset(InputControl inputControl, Map<String, Object> parameters, int size, Map<String, String> errors) {
        Object offset_param_value = parameters.get(inputControl.getName() +"_"+ OFFSET);
        if(offset_param_value != null) {
            int offset = 0;
            try {
                offset = Integer.parseInt((String) offset_param_value);
            } catch(NumberFormatException e) {
                throwException(OFFSET, offset, errors);
                return offset;
            }

            //check if the offset is out of range
            validateOffset(offset, size, errors);
            return offset;
        } else {
            return 0;
        }
    }

    /**
     * validate the offset with the result size.
     * @param offset
     * @param size
     * @return offset
     */
    default int validateOffset(int offset, int size, Map<String, String> errors) {
        if((offset < 0) || (size > 0 && offset >= size)) {
            throwException(OFFSET, offset, errors);
        }
        return offset;
    }

    default void throwException(String fieldName, int value, Map<String, String> errors) {
        if(errors != null) {
            errors.put(fieldName, String.valueOf(value));
        } else {
            throw new InputControlValidationException(OUT_OF_RANGE_ERROR, new Object[]{fieldName, String.valueOf(value)}, null, null);
        }
    }

    /**
     * Get Limit from parameters and validate it.
     * @param inputControl
     * @param parameters
     * @return limit
     */
    default int getLimit(InputControl inputControl, Map<String, Object> parameters, Map<String, String> errors) {
        Object limit_param_value = parameters.get(inputControl.getName() +"_"+ LIMIT);
        if(limit_param_value != null) {
            int limit = Integer.MAX_VALUE;

            try {
                limit = Integer.parseInt((String) limit_param_value);
            } catch(NumberFormatException e) {
                throwException(LIMIT, limit, errors);
                return limit;
            }

            //check if the limit is out of range
            if(limit <= 0) {
                throwException(LIMIT, limit, errors);
            }
            return limit;
        } else {
            return Integer.MAX_VALUE;
        }
    }

    /**
     * @param parameters
     * @param size
     */
    default void addTotalCountToParameters(Map<String, Object> parameters, int size) {
        if(parameters.get("includeTotalCount") != null) {
            if(parameters.get("includeTotalCount").equals("true")) {
                parameters.put(TOTAL_COUNT, size);
            }
        }
    }

    /**
     * @param limit
     * @param offset
     * @param resultSize
     * @return totalLimit
     */
    default int getTotalLimit(int limit, int offset, int resultSize) {

        //check for integer overflow and return size instead of catching the overflow.
        long sum = (long) limit + (long) offset;
        if (sum >= Integer.MAX_VALUE) {
            return resultSize;
        }
        return Math.min((limit + offset), resultSize);
    }

    default void checkLimitOffsetRange(Map<String, String> errors) {
        if(!errors.isEmpty()) {
            throw new InputControlValidationException( OUT_OF_RANGE_ERROR, new Object[]{errors.keySet(), errors.values()}, null, null);
        }
    }
}
