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
import com.jaspersoft.jasperserver.api.metadata.common.domain.client.ListOfValuesItemImpl;

import org.junit.Before;
import org.junit.Test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.spy;

public class ListOvValuesLoaderTest {
    ListOvValuesLoader valuesLoader;

    @Before
    public void setup()  {
        valuesLoader = spy(new ListOvValuesLoader());
    }
    @Test
    public void getTotalCountByCriteria_withValidLabels() {
        List<ListOfValuesItem> values = new ArrayList<>();
        ListOfValuesItem listOfValuesItem1 = new ListOfValuesItemImpl();
        listOfValuesItem1.setLabel("USA");
        listOfValuesItem1.setValue("USA");
        values.add(listOfValuesItem1);
        ListOfValuesItem listOfValuesItem2 = new ListOfValuesItemImpl();
        listOfValuesItem2.setLabel("Canada");
        listOfValuesItem2.setValue("Canada");
        values.add(listOfValuesItem2);

        assertEquals(1, valuesLoader.getTotalCountByCriteria(values, "S"));

    }

    @Test
    public void filterListOfValuesItems_withLimitOfOneValue() {
        InputControl inputControl = mock(InputControl.class);
        ReportInputControlInformation info = mock(ReportInputControlInformation.class);

        List<ListOfValuesItem> values = new ArrayList<>();
        ListOfValuesItem listOfValuesItem1 = new ListOfValuesItemImpl();
        listOfValuesItem1.setLabel("USA");
        listOfValuesItem1.setValue("USA");
        values.add(listOfValuesItem1);
        ListOfValuesItem listOfValuesItem2 = new ListOfValuesItemImpl();
        listOfValuesItem2.setLabel("Canada");
        listOfValuesItem2.setValue("Canada");

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("Country", "USA");


        doReturn(1).when(valuesLoader).getTotalLimit(1, 0, 1);
        doReturn(1).when(valuesLoader).getLimit(inputControl, parameters, null);
        doReturn(0).when(valuesLoader).getOffset(inputControl, parameters, 1, null);

        List<ListOfValuesItem> actualResult = valuesLoader.filterListOfValuesItems(values, parameters, inputControl);
        assertEquals(actualResult.size(), 1);
        assertEquals(actualResult.get(0).getValue(), "USA");
    }

}
