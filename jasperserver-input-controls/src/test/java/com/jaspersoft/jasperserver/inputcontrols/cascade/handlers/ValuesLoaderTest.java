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

import com.jaspersoft.jasperserver.api.metadata.common.domain.InputControl;
import com.jaspersoft.jasperserver.api.metadata.common.domain.ListOfValuesItem;
import com.jaspersoft.jasperserver.api.metadata.common.domain.client.ListOfValuesItemImpl;
import com.jaspersoft.jasperserver.dto.reports.inputcontrols.InputControlState;
import com.jaspersoft.jasperserver.inputcontrols.cascade.InputControlValidationException;
import org.junit.Before;
import org.junit.Test;
import java.util.*;

import static org.junit.Assert.*;
import static org.mockito.Mockito.*;
public class ValuesLoaderTest {

    ValuesLoader valuesLoader;

    @Before
    public void setup() {
        valuesLoader = mock(ValuesLoader.class);
    }

    @Test
    public void checkCriteriaAndAddItem_withAnyParameterValue() {
        List<ListOfValuesItem> result = new ArrayList<>();
        ListOfValuesItem item = new ListOfValuesItemImpl();
        item.setLabel("USA");
        doCallRealMethod().when(valuesLoader).checkCriteriaAndAddItem(anyString(), anyList(), any(ListOfValuesItem.class));

        valuesLoader.checkCriteriaAndAddItem("USA", result, item);
        assertEquals(result.get(0).getLabel(), "USA");

        result.clear();
        valuesLoader.checkCriteriaAndAddItem("Mexico", result, item);
        assertTrue(result.isEmpty());
    }


    @Test
    public void checkLimitAndAddItem_withAnyParameterValue() {
        List<ListOfValuesItem> result = new ArrayList<>();
        ListOfValuesItem listOfValuesItem = new ListOfValuesItemImpl();
        listOfValuesItem.setLabel("USA");
        result.add(listOfValuesItem);

        ListOfValuesItem item = new ListOfValuesItemImpl();
        item.setLabel("Canada");

        doCallRealMethod().when(valuesLoader).checkLimitAndAddItem(anyString(), anyInt(), anyList(), any(ListOfValuesItem.class));
        assertTrue(valuesLoader.checkLimitAndAddItem("Canada", 2, result, item));
        assertFalse(valuesLoader.checkLimitAndAddItem("Canada", 1, result, item));
    }

    @Test
    public void getCriteria_withAnyParameterValue() {
        Map<String, Object> parameters = new HashMap<>();
        InputControl inputControl = mock(InputControl.class);
        when(inputControl.getName()).thenReturn("Country");

        doCallRealMethod().when(valuesLoader).getCriteria(any(InputControl.class), any(Map.class));
        assertNull(valuesLoader.getCriteria(inputControl, parameters));

        parameters.put("Country_criteria", "USA");
        assertEquals("USA", valuesLoader.getCriteria(inputControl, parameters));
    }


    @Test
    public void getOffset_withAnyParameterValue() {
        Map<String, Object> parameters = new HashMap<>();
        InputControl inputControl = mock(InputControl.class);
        when(inputControl.getName()).thenReturn("Country");


        doCallRealMethod().when(valuesLoader).getOffset(any(InputControl.class), any(Map.class), anyInt(), nullable(Map.class));
        doCallRealMethod().when(valuesLoader).validateOffset(anyInt(), anyInt(), nullable(Map.class));
        doCallRealMethod().when(valuesLoader).throwException(anyString(), anyInt(), nullable(Map.class));
        assertEquals(valuesLoader.getOffset(inputControl, parameters, 10, null), 0);

        parameters.put("Country_offset", "1");
        assertEquals(1, valuesLoader.getOffset(inputControl, parameters, 10, null));
        // with negative offset
        try{
            parameters.put("Country_offset", "-1");
            valuesLoader.getOffset(inputControl, parameters, 10, null);
            fail("expected InputControlValidationException");
        } catch(InputControlValidationException e) {
            assertNotNull(e);
        }

        //with offset equal to size
        try{
            parameters.put("Country_offset", "10");
            valuesLoader.getOffset(inputControl, parameters, 10, null);
            fail("expected InputControlValidationException");
        } catch(InputControlValidationException e) {
            assertNotNull(e);
        }
    }

    @Test
    public void getLimit_withAnyParameterValue() {
        Map<String, Object> parameters = new HashMap<>();
        InputControl inputControl = mock(InputControl.class);
        when(inputControl.getName()).thenReturn("Country");

        doCallRealMethod().when(valuesLoader).getLimit(any(InputControl.class), any(Map.class), nullable(Map.class));
        doCallRealMethod().when(valuesLoader).throwException(anyString(), anyInt(), nullable(Map.class));
        assertEquals(valuesLoader.getLimit(inputControl, parameters, null), Integer.MAX_VALUE);

        parameters.put("Country_limit", "2");
        assertEquals(2, valuesLoader.getLimit(inputControl, parameters, null));

        // with negative limit
        try{
            parameters.put("Country_limit", "-1");
            valuesLoader.getLimit(inputControl, parameters, null);
            fail("expected InputControlValidationException");
        } catch(InputControlValidationException e) {
            assertNotNull(e);
        }
    }

    @Test
    public void addTotalCountToParameters_withIncludeTotalCount() {
        InputControlState inputControlState = new InputControlState();

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("includeTotalCount", "true");

        doCallRealMethod().when(valuesLoader).addTotalCountToParameters(anyMap(), anyInt());
        valuesLoader.addTotalCountToParameters(parameters, 10);
        assertEquals(10, parameters.get("totalCount"));
    }


    @Test
    public void getTotalLimit_withAnyValue() {
        doCallRealMethod().when(valuesLoader).getTotalLimit(anyInt(), anyInt(), anyInt());
        // with limit + offset less than total size
        assertEquals(3, valuesLoader.getTotalLimit(2,1, 4));

        // with limit + offset greater than size
        assertEquals(4, valuesLoader.getTotalLimit(5,1, 4));

        // with limit + offset greater than Int Max value
        assertEquals(4, valuesLoader.getTotalLimit(Integer.MAX_VALUE,1, 4));
    }
}
