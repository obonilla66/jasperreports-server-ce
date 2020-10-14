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
import com.jaspersoft.jasperserver.api.metadata.common.domain.ListOfValues;
import com.jaspersoft.jasperserver.api.metadata.common.domain.ListOfValuesItem;
import com.jaspersoft.jasperserver.api.metadata.common.domain.ResourceReference;
import com.jaspersoft.jasperserver.api.metadata.common.domain.client.ListOfValuesItemImpl;
import com.jaspersoft.jasperserver.inputcontrols.cascade.CachedRepositoryService;
import com.jaspersoft.jasperserver.inputcontrols.cascade.CascadeResourceNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;


import static com.jaspersoft.jasperserver.inputcontrols.cascade.handlers.InputControlHandler.NOTHING_SUBSTITUTION_LABEL;
import static com.jaspersoft.jasperserver.inputcontrols.cascade.handlers.InputControlHandler.NOTHING_SUBSTITUTION_VALUE;


/**
 * @author Yaroslav.Kovalchyk
 * @version $Id$
 */
@Service
public class ListOvValuesLoader implements ValuesLoader{
    @Resource
    private CachedRepositoryService cachedRepositoryService;
    @Override
    public List<ListOfValuesItem> loadValues(InputControl inputControl, ResourceReference dataSource, Map<String, Object> parameters, Map<String, Class<?>> parameterTypes, ReportInputControlInformation info, boolean isSingleSelect) throws CascadeResourceNotFoundException {
        List<ListOfValuesItem> listOfValuesItems;
        final ListOfValues listOfValues = cachedRepositoryService.getResource(ListOfValues.class, inputControl.getListOfValues());

        if(listOfValues != null) {
            listOfValuesItems = createAndAddListOfValuesItems(listOfValues, isSingleSelect, inputControl);
            return filterListOfValuesItems(listOfValuesItems, parameters, inputControl);
        } else {
            return null;
        }
    }

    protected List<ListOfValuesItem> filterListOfValuesItems(List<ListOfValuesItem> listOfValuesItems,Map<String, Object> parameters, InputControl inputControl){
        List<ListOfValuesItem> result = new ArrayList<>();
        Map<String, String> errors = new HashMap<>();
        int limit = getLimit(inputControl, parameters, errors);
        int offset = getOffset(inputControl, parameters, listOfValuesItems.size(), errors);

        checkLimitOffsetRange(errors);
        int toIndex;
        String criteria = getCriteria(inputControl, parameters);
        int totalLimit = getTotalLimit(limit, offset, listOfValuesItems.size());

        if(criteria != null) {
            int totalCount = getTotalCountByCriteria(listOfValuesItems, criteria);
            addTotalCountToParameters(parameters, totalCount);
        } else {
            addTotalCountToParameters(parameters, listOfValuesItems.size());
        }

        for(ListOfValuesItem item: listOfValuesItems) {
            /**
             * If the limit-offset is provided, filter the results based on the totalLimit
             * and filter by search criteria when provided and then add item to result.
             */
            if (!checkLimitAndAddItem(criteria, totalLimit, result, item)) {
                //when result size reached the limit then break;
                break;
            }
        }

        //get the toIndex based on the constructed result list size
        toIndex = getTotalLimit(limit, offset, result.size());
        /** Validate to see if offset is more than the result size
         * before getting the sublist.
         */
        return result.subList(validateOffset(offset, result.size(), null), toIndex);
    }

    @Override
    public Set<String> getMasterDependencies(InputControl inputControl, ResourceReference dataSource) {
        // no master dependencies for this type
        return null;
    }

    protected int getTotalCountByCriteria(List<ListOfValuesItem> listOfValuesItems, String criteria) {
        int totalCount = 0;
        for(ListOfValuesItem item : listOfValuesItems) {
            if(StringUtils.containsIgnoreCase(item.getLabel(), criteria)) {
                totalCount++;
            }
        }
        return totalCount;
    }

    private List<ListOfValuesItem> createAndAddListOfValuesItems(ListOfValues listOfValues, boolean isSingleSelect, InputControl inputControl) {
        List<ListOfValuesItem> listOfValuesItems;
            if(isSingleSelect && !inputControl.isMandatory()) {
                listOfValuesItems = new ArrayList<>();
                ListOfValuesItem item = new ListOfValuesItemImpl();
                item.setValue(NOTHING_SUBSTITUTION_VALUE);
                item.setLabel(NOTHING_SUBSTITUTION_LABEL);

                listOfValuesItems.add(item);
                listOfValuesItems.addAll(Arrays.asList(listOfValues.getValues()));
            } else {
                listOfValuesItems = Arrays.asList(listOfValues.getValues());
            }
            return listOfValuesItems;
    }


}
