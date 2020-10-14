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
import com.jaspersoft.jasperserver.inputcontrols.cascade.CascadeResourceNotFoundException;
import com.jaspersoft.jasperserver.inputcontrols.cascade.InputControlValidationException;
import org.apache.commons.collections.OrderedMap;
import org.apache.commons.collections.map.LinkedMap;
import org.junit.Before;
import org.junit.Test;

import java.util.List;

import static com.jaspersoft.jasperserver.inputcontrols.cascade.handlers.InputControlHandler.NOTHING_SUBSTITUTION_LABEL;
import static com.jaspersoft.jasperserver.inputcontrols.cascade.handlers.InputControlHandler.NOTHING_SUBSTITUTION_VALUE;
import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.*;

public class QueryValuesLoaderTest {

    QueryValuesLoader valuesLoader;

    @Before
    public void setup() {
        valuesLoader = spy(new QueryValuesLoader());
    }


    @Test
    public void getListOfValuesItems_validateLimitAndOffset() throws CascadeResourceNotFoundException {
        InputControl inputControl = mock(InputControl.class);
        ReportInputControlInformation info = mock(ReportInputControlInformation.class);

        OrderedMap om = new LinkedMap();
        om.put("USA", new Object[]{"USA"});
        om.put("Canada", new Object[]{"Canada"});
        om.put("Mexico", new Object[]{"Mexico"});

        doReturn("").when(valuesLoader).extractLabelFromResults(any(InputControl.class), any(ReportInputControlInformation.class), any(Object[].class), any(StringBuilder.class));

        List<ListOfValuesItem> actualResult = valuesLoader.getListOfValuesItems(inputControl, info, null, 3, 0, 3, om);
        assertEquals(actualResult.size(), 3);
    }

    @Test
    public void getListOfValuesItems_withDifferentOffset() throws CascadeResourceNotFoundException {
        InputControl inputControl = mock(InputControl.class);
        ReportInputControlInformation info = mock(ReportInputControlInformation.class);

        OrderedMap om = new LinkedMap();
        om.put("USA", new Object[]{"USA"});
        om.put("Canada", new Object[]{"Canada"});
        om.put("Mexico", new Object[]{"Mexico"});


        doReturn("").when(valuesLoader).extractLabelFromResults(any(InputControl.class), any(ReportInputControlInformation.class), any(Object[].class), any(StringBuilder.class));

        List<ListOfValuesItem> actualResult = valuesLoader.getListOfValuesItems(inputControl, info, null, 2, 2, 3, om);
        assertEquals(actualResult.size(), 1);
        assertEquals(actualResult.get(0).getValue(), "Mexico");
    }

    @Test(expected = InputControlValidationException.class)
    public void getListOfValuesItems_withOutOfRangeOffset() throws CascadeResourceNotFoundException {
        InputControl inputControl = mock(InputControl.class);
        ReportInputControlInformation info = mock(ReportInputControlInformation.class);

        OrderedMap om = new LinkedMap();
        om.put("USA", new Object[]{"USA"});
        om.put("Canada", new Object[]{"Canada"});
        om.put("Mexico", new Object[]{"Mexico"});

        doReturn("").when(valuesLoader).extractLabelFromResults(any(InputControl.class), any(ReportInputControlInformation.class), any(Object[].class), any(StringBuilder.class));

        valuesLoader.getListOfValuesItems(inputControl, info, null, 2, 3, 3, om);
    }

    @Test
    public void getListOfValuesItems_withOutOfRangeLimit() throws CascadeResourceNotFoundException {
        InputControl inputControl = mock(InputControl.class);
        ReportInputControlInformation info = mock(ReportInputControlInformation.class);

        OrderedMap map = new LinkedMap();
        map.put("USA", new Object[]{"USA"});
        map.put("Canada", new Object[]{"Canada"});
        map.put("Mexico", new Object[]{"Mexico"});

        doReturn("").when(valuesLoader).extractLabelFromResults(any(InputControl.class), any(ReportInputControlInformation.class), any(Object[].class), any(StringBuilder.class));
        List<ListOfValuesItem> actualResult = valuesLoader.getListOfValuesItems(inputControl, info, null, 4, 0, 4, map);
        assertEquals(actualResult.size(), 3);
    }

    @Test
    public void getListOfValuesItems_NothingValueShouldBeOnTop() throws CascadeResourceNotFoundException {
        InputControl inputControl = mock(InputControl.class);
        ReportInputControlInformation info = mock(ReportInputControlInformation.class);

        OrderedMap map = new LinkedMap();
        map.put("USA", new Object[]{"USA"});
        map.put("Canada", new Object[]{"Canada"});
        map.put("Mexico", new Object[]{"Mexico"});
        map.put(NOTHING_SUBSTITUTION_VALUE, new Object[]{NOTHING_SUBSTITUTION_LABEL});

        doReturn("").when(valuesLoader).extractLabelFromResults(any(InputControl.class), any(ReportInputControlInformation.class), any(Object[].class), any(StringBuilder.class));
        List<ListOfValuesItem> actualResult = valuesLoader.getListOfValuesItems(inputControl, info, null, 2, 0, 2, map);
        assertEquals(actualResult.size(), 2);
        assertEquals(actualResult.get(0).getLabel(), NOTHING_SUBSTITUTION_LABEL);
    }

    @Test
    public void getTotalCountByCriteria_withValidLabels() throws CascadeResourceNotFoundException {
        String state = "USA|CA";
        InputControl inputControl = mock(InputControl.class);
        ReportInputControlInformation info = mock(ReportInputControlInformation.class);
        OrderedMap om = new LinkedMap();
        om.put("CA", new Object[]{"CA"});
        doReturn(state).when(valuesLoader).extractLabelFromResults(any(InputControl.class), any(ReportInputControlInformation.class), any(Object[].class), any(StringBuilder.class));
        assertEquals(1, valuesLoader.getTotalCountByCriteria(inputControl, info, om, "S"));

    }

}
