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

import com.jaspersoft.jasperserver.api.common.util.diagnostic.DiagnosticSnapshotPropertyHelper;
import com.jaspersoft.jasperserver.api.engine.common.service.ReportInputControlInformation;
import com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.JasperReportInputControlInformation;
import com.jaspersoft.jasperserver.api.metadata.common.domain.DataType;
import com.jaspersoft.jasperserver.api.metadata.common.domain.InputControl;
import com.jaspersoft.jasperserver.api.metadata.common.domain.ListOfValuesItem;
import com.jaspersoft.jasperserver.api.metadata.common.domain.ResourceReference;
import com.jaspersoft.jasperserver.api.metadata.common.domain.client.ListOfValuesItemImpl;
import com.jaspersoft.jasperserver.inputcontrols.cascade.CascadeResourceNotFoundException;
import com.jaspersoft.jasperserver.dto.reports.inputcontrols.InputControlOption;
import com.jaspersoft.jasperserver.dto.reports.inputcontrols.InputControlState;
import com.jaspersoft.jasperserver.inputcontrols.cascade.handlers.converters.DataConverterService;

import org.apache.commons.collections.set.ListOrderedSet;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import java.math.BigDecimal;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertFalse;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.ArgumentMatchers.anyObject;
import static org.mockito.ArgumentMatchers.anyMap;
import static org.mockito.ArgumentMatchers.nullable;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Matchers.any;
import static org.mockito.Matchers.anyBoolean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Arrays;

import static com.jaspersoft.jasperserver.inputcontrols.cascade.handlers.ParametersHelper.entry;
import static com.jaspersoft.jasperserver.inputcontrols.cascade.handlers.ParametersHelper.listOfOptions;
import static com.jaspersoft.jasperserver.inputcontrols.cascade.handlers.ParametersHelper.listOfValues;
import static com.jaspersoft.jasperserver.inputcontrols.cascade.handlers.ParametersHelper.map;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.lenient;
import static org.mockito.Mockito.when;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.spy;
import static org.mockito.Mockito.doThrow;


/**
 * @author Yaroslav.Kovalchyk
 * @version $Id$
 */
@RunWith(MockitoJUnitRunner.class)
public class SingleSelectListInputControlHandlerTest {
    @InjectMocks
    private SingleSelectListInputControlHandler handler;

    @Mock
    private ValuesLoader loader;

    @Mock
    protected DataConverterService dataConverterService;

    @Mock
    private InputControl inputControl;

    @Mock
    private ReportInputControlInformation reportInputControlInformation;

    List<ListOfValuesItem> values;

    @Before
    public void setup() {
        values = getListOfValuesItem();
    }
    /**
     * Incoming value is of type Integer.
     * List of values for input control contains values ot type BigDecimal.
     * Integer value has corresponding BigDecimal equivalent in list of values and corresponding option become selected.
     * @throws Exception
     */
    @Test
    public void getStateOfInputControlNumberWithListOfBigDecimalAndIntegerValue() throws Exception {
        final String parameterName = "testName";
        // incoming value is of type Integer
        final Integer integerValue = Integer.valueOf(2);
        // BigDecimal equivalent of incoming value
        final BigDecimal bigDecimalValue = BigDecimal.valueOf(2);

        doReturn(parameterName).when(inputControl).getName();
        final HashMap<String, Class<?>> parameterTypes = new HashMap<String, Class<?>>();
        Map<String, Object> inputParameters = map(entry(parameterName, integerValue));

        // building list of values from BigDecimals
        final List<ListOfValuesItem> listOfValues = listOfValues(BigDecimal.valueOf(0), BigDecimal.valueOf(1), bigDecimalValue, BigDecimal.valueOf(3), BigDecimal.valueOf(4));
        doReturn(listOfValues).when(loader).loadValues(eq(inputControl), nullable(ResourceReference.class), eq(inputParameters), eq(parameterTypes), eq(reportInputControlInformation), anyBoolean());
        // dummy data conversion
        doReturn(bigDecimalValue.toString()).when(dataConverterService).formatSingleValue(eq(bigDecimalValue), eq(inputControl), eq(reportInputControlInformation));

        ////////////tested method call/////////////////
        final List<InputControlOption> options = handler.getState(inputControl, null, inputParameters, parameterTypes, reportInputControlInformation).getOptions();
        // state should have options
        assertNotNull(options);
        // options number is one item more then values because of nothing selected item.
        assertEquals(listOfValues.size(), options.size());
        List<InputControlOption> selectedOptions = new ArrayList<InputControlOption>();
        for (InputControlOption currentOption : options) {
            if (currentOption.isSelected() != null && currentOption.isSelected()) selectedOptions.add(currentOption);
        }
        // only one item is selected
        assertEquals(selectedOptions.size(), 1);
        // selected item is string representation of BigDecimal, which is equivalent to incoming Integer value
        assertEquals(selectedOptions.get(0).getValue(), bigDecimalValue.toString());
    }

    @Test
    public void getStateOfInputControlNumberWith_FirstValueSelected() throws Exception {
        final String parameterName = "testName";
        // incoming value is of type Integer
        final Integer integerValue = Integer.valueOf(3);
        // BigDecimal equivalent of incoming value
        final BigDecimal bigDecimalValue = BigDecimal.valueOf(2);

        doReturn(parameterName).when(inputControl).getName();
        doReturn(true).when(inputControl).isMandatory();
        final HashMap<String, Class<?>> parameterTypes = new HashMap<String, Class<?>>();
        Map<String, Object> inputParameters = map(entry(parameterName, integerValue));

        // building list of values from BigDecimals
        final List<ListOfValuesItem> listOfValues = listOfValues(BigDecimal.valueOf(0));
        doReturn(listOfValues).when(loader).loadValues(eq(inputControl), nullable(ResourceReference.class), eq(inputParameters), eq(parameterTypes), eq(reportInputControlInformation), anyBoolean());
        ////////////tested method call/////////////////
        final List<InputControlOption> options = handler.getState(inputControl, null, inputParameters, parameterTypes, reportInputControlInformation).getOptions();
        // state should have options
        assertNotNull(options);
        // options number is one item more then values because of nothing selected item.
        assertEquals(listOfValues.size(), options.size());
        assertEquals(options.get(0).isSelected(), true);
    }

    @Test(expected = NullPointerException.class)
    public void getStateOfInputControlNumberWith_NoValueSelected() throws Exception {
        final String parameterName = "testName";
        final String parameterName_offset = "testName_offset";
        // incoming value is of type Integer
        final Integer integerValue = Integer.valueOf(3);
        // BigDecimal equivalent of incoming value
        final BigDecimal bigDecimalValue = BigDecimal.valueOf(2);

        doReturn(parameterName).when(inputControl).getName();
        doReturn(true).when(inputControl).isMandatory();
        final HashMap<String, Class<?>> parameterTypes = new HashMap<String, Class<?>>();
        Map<String, Object> inputParameters = map(entry(parameterName, integerValue), entry(parameterName_offset, "2"));

        // building list of values from BigDecimals
        final List<ListOfValuesItem> listOfValues = listOfValues(BigDecimal.valueOf(0));
        doReturn(listOfValues).when(loader).loadValues(eq(inputControl), nullable(ResourceReference.class), eq(inputParameters), eq(parameterTypes), eq(reportInputControlInformation), anyBoolean());

        ////////////tested method call/////////////////
        final List<InputControlOption> options = handler.getState(inputControl, null, inputParameters, parameterTypes, reportInputControlInformation).getOptions();
        // state should have options
        assertNotNull(options);
        // options number is one item more then values because of nothing selected item.
        assertEquals(listOfValues.size(), options.size());
        assertEquals(options.get(0).isSelected(), false);
    }

    /**
     * Incoming value is of type BigDecimal.
     * List of values for input control contains values ot type Integer.
     * BigDecimal value has corresponding Integer equivalent in list of values and corresponding option become selected.
     * @throws Exception
     */
    @Test
    public void getStateOfInputControlNumberWithListOfIntegerAndBigDecimalValue() throws Exception {
        final String parameterName = "testName";
        // incoming value is of type BigDecimal
        final BigDecimal bigDecimalValue = BigDecimal.valueOf(3);
        // Integer equivalent of incoming value
        final Integer integerValue = 3;

        doReturn(parameterName).when(inputControl).getName();
        final HashMap<String, Class<?>> parameterTypes = new HashMap<String, Class<?>>();
        Map<String, Object> inputParameters = map(entry(parameterName, bigDecimalValue));
        // building list of values from Integers
        final List<ListOfValuesItem> listOfValues = listOfValues(Integer.valueOf(0), Integer.valueOf(1), Integer.valueOf(2), integerValue, Integer.valueOf(4));
        doReturn(listOfValues).when(loader).loadValues(eq(inputControl), nullable(ResourceReference.class), eq(inputParameters), eq(parameterTypes), eq(reportInputControlInformation), anyBoolean());
        // dummy data conversion
        doReturn(integerValue.toString()).when(dataConverterService).formatSingleValue(eq(integerValue), eq(inputControl), eq(reportInputControlInformation));
        ////////////tested method call/////////////////
        final List<InputControlOption> options = handler.getState(inputControl, null, inputParameters, parameterTypes, reportInputControlInformation).getOptions();
        // state should have options
        assertNotNull(options);
        // options number is one item more then values because of nothing selected item.
        assertEquals(listOfValues.size(), options.size());
        List<InputControlOption> selectedOptions = new ArrayList<InputControlOption>();
        for (InputControlOption currentOption : options) {
            if (currentOption.isSelected() != null && currentOption.isSelected()) selectedOptions.add(currentOption);
        }
        // only one item is selected
        assertEquals(selectedOptions.size(), 1);
        // selected item is string representation of Integer, which is equivalent to incoming BigDecimal value
        assertEquals(selectedOptions.get(0).getValue(), integerValue.toString());
    }

    /**
     * Input control options ot type Long.
     * Checks if Numbers matcher works well for Long type. Covers the bugzilla #33225 case.
     * @throws Exception
     */
    @Test
    public void getStateOfInputControlNumberWithListOfLong() throws Exception {
        final String parameterName = "testName";
        // Selected value is of type Long
        final Long selectedValue = Long.valueOf("49539595901085460");

        doReturn(parameterName).when(inputControl).getName();
        final HashMap<String, Class<?>> parameterTypes = new HashMap<String, Class<?>>();
        Map<String, Object> inputParameters = map(entry(parameterName, selectedValue));
        // building list of values from Longs
        final List<ListOfValuesItem> listOfValues = listOfValues(Long.valueOf("0"),Long.valueOf("49539595901085457"),
                Long.valueOf("49539595901085458"), Long.valueOf("49539595901085459"), selectedValue,  Long.valueOf("49539595901085461"));

        doReturn(listOfValues).when(loader).loadValues(eq(inputControl), nullable(ResourceReference.class), eq(inputParameters), eq(parameterTypes), eq(reportInputControlInformation), anyBoolean());

        doAnswer(invocationOnMock ->
                invocationOnMock.getArguments()[0].toString()
        ).when(dataConverterService).formatSingleValue(nullable(Object.class), any(InputControl.class), eq(reportInputControlInformation));

        ////////////tested method call/////////////////
        final List<InputControlOption> options = handler.getState(inputControl, null, inputParameters, parameterTypes, reportInputControlInformation).getOptions();
        // state should have options
        assertNotNull(options);
        // options number is one item more then values because of nothing selected item.
        assertEquals(listOfValues.size(), options.size());
        List<InputControlOption> selectedOptions = new ArrayList<InputControlOption>();
        for (InputControlOption currentOption : options) {
            if (currentOption.isSelected() != null && currentOption.isSelected()) selectedOptions.add(currentOption);
        }
        // only one item is selected
        assertEquals(selectedOptions.size(), 1);
        // selected item is string representation of Integer, which is equivalent to incoming BigDecimal value
        assertEquals(selectedOptions.get(0).getValue(), selectedValue.toString());
    }

    @Test
    public void populateSelectedValuesList_checkDefaultValue() throws CascadeResourceNotFoundException {
        SingleSelectListInputControlHandler selectListInputControlHandler = spy(new MultiSelectListInputControlHandler());
        DataConverterService dataConverterService = mock(DataConverterService.class);

        InputControl inputControl = null;
        ReportInputControlInformation info = null;
        boolean isNothingSelected = false;
        List<String> defaultValue = new ArrayList<>();
        defaultValue.add("USA");
        defaultValue.add("Canada");

        List<InputControlOption> selectedValues = new ArrayList<>();
        selectListInputControlHandler.setDataConverterService(dataConverterService);

        when(selectListInputControlHandler.getCurrentItemValue(null, null, values.get(0))).thenReturn("USA");
        when(selectListInputControlHandler.getCurrentItemValue(null, null, values.get(1))).thenReturn("Canada");
        when(selectListInputControlHandler.getCurrentItemValue(null, null, values.get(2))).thenReturn("Mexico");

        selectListInputControlHandler.populateSelectedValuesList(inputControl, info, selectedValues, new ArrayList<>(), null, values, defaultValue, isNothingSelected);

        assertThat(selectedValues.get(0).getLabel(), is(defaultValue.get(0)));
    }


    @Test
    public void populateSelectedValuesList_validateNothingValue() throws CascadeResourceNotFoundException {
        SingleSelectListInputControlHandler selectListInputControlHandler = spy(new SingleSelectListInputControlHandler());
        DataConverterService dataConverterService = mock(DataConverterService.class);
        InputControl inputControl = mock(InputControl.class);
        when(inputControl.isMandatory()).thenReturn(false);
        ReportInputControlInformation info = null;
        boolean isNothingSelected = true;
        List<String> defaultValue = new ArrayList<>();
        defaultValue.add("---");

        List<InputControlOption> selectedValues = new ArrayList<>();
        selectListInputControlHandler.setDataConverterService(dataConverterService);
        when(selectListInputControlHandler.getCurrentItemValue(inputControl, info, values.get(0))).thenReturn("USA");
        when(selectListInputControlHandler.getCurrentItemValue(inputControl, info, values.get(1))).thenReturn("Canada");
        when(selectListInputControlHandler.getCurrentItemValue(inputControl, info, values.get(2))).thenReturn("Mexico");

        selectListInputControlHandler.populateSelectedValuesList(inputControl, info, selectedValues, new ArrayList<>(),null, values, null, isNothingSelected);

        assertThat(selectedValues.get(0).getLabel(), is(defaultValue.get(0)));
    }

    @Test
    public void populateSelectedValuesList_checkDefaultFirstValue() throws CascadeResourceNotFoundException {
        SingleSelectListInputControlHandler selectListInputControlHandler = spy(new MultiSelectListInputControlHandler());
        DataConverterService dataConverterService = mock(DataConverterService.class);
        InputControl inputControl = mock(InputControl.class);
        when(inputControl.isMandatory()).thenReturn(true);
        ReportInputControlInformation info = null;
        boolean isNothingSelected = false;
        List<String> defaultValue = new ArrayList<>();
        defaultValue.add("USA");

        List<InputControlOption> selectedValues = new ArrayList<>();
        selectListInputControlHandler.setDataConverterService(dataConverterService);
        when(selectListInputControlHandler.getCurrentItemValue(inputControl, info, values.get(0))).thenReturn("USA");
        when(selectListInputControlHandler.getCurrentItemValue(inputControl, info, values.get(1))).thenReturn("Canada");
        when(selectListInputControlHandler.getCurrentItemValue(inputControl, info, values.get(2))).thenReturn("Mexico");

        selectListInputControlHandler.populateSelectedValuesList(inputControl, info, selectedValues, new ArrayList<>(),null, values, null, isNothingSelected);

        assertThat(selectedValues.get(0).getLabel(), is(defaultValue.get(0)));
    }

    @Test
    public void populateSelectedValuesWithNoLabel_withValueList() throws CascadeResourceNotFoundException {
        SingleSelectListInputControlHandler selectListInputControlHandler = spy(new MultiSelectListInputControlHandler());
        DataConverterService dataConverterService = mock(DataConverterService.class);
        InputControl inputControl = mock(InputControl.class);
        ReportInputControlInformation info = null;
        List<String> defaultValue = new ArrayList<>();
        defaultValue.add("USA");

        List<InputControlOption> selectedValues = new ArrayList<>();
        selectListInputControlHandler.setDataConverterService(dataConverterService);
        doReturn("USA").when(dataConverterService).formatSingleValue(anyObject(), nullable(InputControl.class), nullable(ReportInputControlInformation.class));

        selectListInputControlHandler.populateSelectedValuesWithNoLabel(inputControl, info, selectedValues, new ArrayList<>(), defaultValue);
        assertThat(selectedValues.get(0).getValue(), is(defaultValue.get(0)));
        assertNull(selectedValues.get(0).getLabel());

    }

    @Test
    public void populateSelectedValuesWithNoLabel_withSingleValue() throws CascadeResourceNotFoundException {
        SingleSelectListInputControlHandler selectListInputControlHandler = spy(new SingleSelectListInputControlHandler());
        DataConverterService dataConverterService = mock(DataConverterService.class);
        InputControl inputControl = mock(InputControl.class);
        ReportInputControlInformation info = null;
        String defaultValue = "USA";

        List<InputControlOption> selectedValues = new ArrayList<>();
        selectListInputControlHandler.setDataConverterService(dataConverterService);
        doReturn("USA").when(dataConverterService).formatSingleValue(anyObject(), nullable(InputControl.class), nullable(ReportInputControlInformation.class));

        selectListInputControlHandler.populateSelectedValuesWithNoLabel(inputControl, info, selectedValues, new ArrayList<>(), defaultValue);
        assertThat(selectedValues.get(0).getValue(), is(defaultValue));
        assertNull(selectedValues.get(0).getLabel());

    }

    @Test
    public void getMandatoryValues_withMandatoryIC() throws CascadeResourceNotFoundException {

        SingleSelectListInputControlHandler selectListInputControlHandler = spy(new SingleSelectListInputControlHandler());
        DataConverterService dataConverterService = mock(DataConverterService.class);
        InputControl inputControl = mock(InputControl.class);
        ReportInputControlInformation info = null;


        boolean  isNothingSelected = false;
        List<InputControlOption> selectedValues = new ArrayList<>();
        List<Object> selectedValuesList = new ArrayList<>();

        selectListInputControlHandler.setDataConverterService(dataConverterService);


        doReturn(true).when(inputControl).isMandatory();
        doReturn("USA").when(dataConverterService).formatSingleValue(anyObject(), nullable(InputControl.class), nullable(ReportInputControlInformation.class));


        selectListInputControlHandler.setDataConverterService(dataConverterService);

        selectListInputControlHandler.getMandatoryValues(inputControl, info, selectedValues, selectedValuesList, values,isNothingSelected);
        assertEquals(selectedValuesList.get(0), "USA");
    }

    @Test
    public void fillSelectedValue_withValidSelectedValues() throws CascadeResourceNotFoundException{
        Map<String,List<InputControlOption>> selectedValuesMap;
        SingleSelectListInputControlHandler selectListInputControlHandler = spy(new MultiSelectListInputControlHandler());
        ValuesLoader loader = mock(ValuesLoader.class);
        ReportInputControlInformation info = mock(ReportInputControlInformation.class);
        InputControl inputControl = mock(InputControl.class);

        Map<String,List<String>> result = new HashMap<>();
        result.put("Country", Arrays.asList(new String[]{"USA"}));
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("Country", "USA");
        when(info.getDefaultValue()).thenReturn("USA");
        when(inputControl.getName()).thenReturn("Country");


        List<InputControlOption> selectedValues = new ArrayList<>();
        selectedValues.add(new InputControlOption().setValue("USA").setLabel("USA"));


        selectListInputControlHandler.setLoader(loader);

        when(selectListInputControlHandler.isNothingSelected(inputControl.getName(), parameters)).thenReturn(true);
        when(selectListInputControlHandler.populateSelectedValuesList(nullable(InputControl.class), nullable(ReportInputControlInformation.class), nullable(List.class), nullable(List.class),nullable(DataType.class),nullable(List.class), nullable(Object.class), anyBoolean())).thenReturn(selectedValues);
        selectedValuesMap = selectListInputControlHandler.fillSelectedValue(inputControl, null, parameters, info, null);
        assertEquals(selectedValues, selectedValuesMap.get("Country"));

    }

    /**
     *  diagnostic datasnapshot contains IC default values
     *  chosen by user when run report under diagnostic
     *
     * @throws Exception
     */
    @Test
    public void getStateOfInputControlFromSingleDefaultValueOfDiagnosticDatasnapshot() throws Exception {
        final String parameterName = "testName";
        final String valueForDefault = "Diagnostic";

        final List<InputControlOption> defaultItems = new ArrayList<InputControlOption>() {{
            add(new InputControlOption(valueForDefault, valueForDefault, true));
        }};

        doReturn(parameterName).when(inputControl).getName();
        final HashMap<String, Class<?>> parameterTypes = new HashMap<String, Class<?>>();
        Map<String, Object> inputParameters = map(
                entry(DiagnosticSnapshotPropertyHelper.ATTRIBUTE_IS_DIAG_SNAPSHOT, Boolean.TRUE),
                entry(parameterName, valueForDefault),
                entry(parameterName+"_offset","1"));

        doReturn(valueForDefault).when(reportInputControlInformation).getDefaultValue();

        final List<ListOfValuesItem> listOfValues = listOfValues(
                Integer.valueOf(-2), Integer.valueOf(-1),
                Integer.valueOf(0), Integer.valueOf(1), Integer.valueOf(2));

        ListOfValuesItem listOfValuesItem = new ListOfValuesItemImpl();
        listOfValuesItem.setLabel("Diagnostic");
        listOfValuesItem.setValue("Diagnostic");
        final List<ListOfValuesItem> expectedResult = new ArrayList<>();
        expectedResult.add(listOfValuesItem);

        doReturn(1).when(loader).getTotalLimit(2, 0, 1);
        doReturn(2).when(loader).getLimit(nullable(InputControl.class), nullable(Map.class), nullable(Map.class) );
        doReturn(0).when(loader).getOffset(nullable(InputControl.class), nullable(Map.class),anyInt(), anyMap());
        doReturn(expectedResult).when(loader).checkCriteriaAndAddItem(nullable(String.class), anyList(), any(ListOfValuesItem.class));


        doReturn(valueForDefault).when(dataConverterService).formatSingleValue(eq(valueForDefault), eq(inputControl), eq(reportInputControlInformation));
        doReturn(valueForDefault).when(dataConverterService).convertSingleValue(eq(valueForDefault), eq(inputControl), eq(reportInputControlInformation));
        ////////////tested method call/////////////////
        final List<InputControlOption> options = handler.getState(inputControl, null, inputParameters, parameterTypes, reportInputControlInformation).getOptions();
        // state should have options
        assertNotNull(options);
        assertFalse("options not same list from db", options.size() == listOfValues.size() + 1);
        assertTrue("option same list of defaults", options.contains(defaultItems.get(0)));

        // options number is one item more then values because of nothing selected item.
        assertEquals(defaultItems.size(), options.size());
        List<InputControlOption> selectedOptions = new ArrayList<InputControlOption>();
        for (InputControlOption currentOption : options) {
            if (currentOption.hasSelected()) {
                selectedOptions.add(currentOption);
            }
        }
        // only one item is selected
        assertEquals(selectedOptions.size(), 1);

    }

    @Test
    public void getStateOfInputControlFromMultiDefaultValueOfDiagnosticDatasnapshot() throws Exception {
        final String parameterName = "testName";

        final List<String> valuesForDefault = new ArrayList<String>() {{
            add("USA");
            add("Canada");
            add("Mexico");
        }};

        final ListOrderedSet defaultICValues = new ListOrderedSet(){{
            addAll(valuesForDefault);
        }};

        final List<InputControlOption> defaultItems = listOfOptions(valuesForDefault, true);

        doReturn(parameterName).when(inputControl).getName();
        final HashMap<String, Class<?>> parameterTypes = new HashMap<String, Class<?>>();
        Map<String, Object> inputParameters = map(
                entry(DiagnosticSnapshotPropertyHelper.ATTRIBUTE_IS_DIAG_SNAPSHOT, Boolean.TRUE),
                entry(parameterName, valuesForDefault.get(1)));

        doReturn(defaultICValues).when(reportInputControlInformation).getDefaultValue();

        final List<ListOfValuesItem> listOfValues = listOfValues(
                Integer.valueOf(-2), Integer.valueOf(-1),
                Integer.valueOf(0), Integer.valueOf(1), Integer.valueOf(2));
        lenient().doReturn(listOfValues).when(loader).loadValues(eq(inputControl), nullable(ResourceReference.class), eq(inputParameters), eq(parameterTypes), eq(reportInputControlInformation), anyBoolean());


        final List<ListOfValuesItem> expectedResult = values;

        doReturn(expectedResult).when(loader).checkCriteriaAndAddItem(nullable(String.class), anyList(), any(ListOfValuesItem.class));
        doReturn(3).when(loader).getTotalLimit(4, 1, 3);
        doReturn(4).when(loader).getLimit(nullable(InputControl.class), nullable(Map.class), nullable(Map.class) );
        doReturn(1).when(loader).getOffset(nullable(InputControl.class), nullable(Map.class),anyInt(), anyMap());


        // dummy data conversion
        doReturn(valuesForDefault.get(0)).when(dataConverterService).formatSingleValue(eq(valuesForDefault.get(0)), eq(inputControl), eq(reportInputControlInformation));
        doReturn(valuesForDefault.get(1)).when(dataConverterService).formatSingleValue(eq(valuesForDefault.get(1)), eq(inputControl), eq(reportInputControlInformation));
        doReturn(valuesForDefault.get(0)).when(dataConverterService).convertSingleValue(eq(valuesForDefault.get(0)), eq(inputControl), eq(reportInputControlInformation));
        doReturn(valuesForDefault.get(1)).when(dataConverterService).convertSingleValue(eq(valuesForDefault.get(1)), eq(inputControl), eq(reportInputControlInformation));
        ////////////tested method call/////////////////
        final List<InputControlOption> options = handler.getState(inputControl, null, inputParameters, parameterTypes, reportInputControlInformation).getOptions();
        // state should have options
        assertNotNull(options);
        assertFalse("options not same list from db", options.size() == listOfValues.size() + 1);
        assertTrue("option same list of defaults", options.contains(defaultItems.get(1)));

        // options number is one item more then values because of nothing selected item.
        assertEquals(defaultItems.size(), options.size());
        List<InputControlOption> selectedOptions = new ArrayList<InputControlOption>();
        for (InputControlOption currentOption : options) {
            if (currentOption.hasSelected()) {
                selectedOptions.add(currentOption);
            }
        }
        // only one item is selected
        assertEquals(selectedOptions.size(), 1);
    }

    @Test
    public void setStateTotalCount_withValidCount() {
        InputControlState inputControlState = new InputControlState();

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("totalCount", "10");

        handler.setStateTotalCount(inputControlState, parameters);
        assertEquals("10", inputControlState.getTotalCount());
    }

    @Test
    public void setStateTotalCount_withNullCount() {
        InputControlState inputControlState = new InputControlState();

        Map<String, Object> parameters = new HashMap<>();

        handler.setStateTotalCount(inputControlState, parameters);
        assertEquals(null, inputControlState.getTotalCount());
    }

    @Test
    public void setIncomingValue_withValidSelectedValue() {
        InputControl inputControl = mock(InputControl.class);
        when(inputControl.getName()).thenReturn("Country");

        ReportInputControlInformation info = mock(ReportInputControlInformation.class);
        when(info.getDefaultValue()).thenReturn("USA");

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("Country_select", "selectedValues");
        parameters.put("Country", "Canada");
        assertEquals("USA", handler.setIncomingValue(inputControl, parameters, info, "Country"));
    }

    @Test
    public void setIncomingValue_withNoSelectedValue() {
        InputControl inputControl = mock(InputControl.class);
        when(inputControl.getName()).thenReturn("Country");

        ReportInputControlInformation info = mock(ReportInputControlInformation.class);

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("Country", "Canada");


        assertEquals("Canada", handler.setIncomingValue(inputControl, parameters, info, "Country"));
    }


    @Test
    public void getDefaultValuesList_withCollectionValue() {
        ReportInputControlInformation info = mock(ReportInputControlInformation.class);
        List<Object> list = new ArrayList<>();
        list.add("USA");

        ListOrderedSet orderedSet = new ListOrderedSet();
        orderedSet.add("USA");
        when(info.getDefaultValue()).thenReturn(orderedSet);

        assertEquals(list, handler.getDefaultValuesList(info));
    }

    @Test
    public void getDefaultValuesList_withSingleValue() {
        ReportInputControlInformation info = mock(ReportInputControlInformation.class);
        List<Object> list = new ArrayList<>();
        list.add("USA");

        when(info.getDefaultValue()).thenReturn("USA");
        assertEquals(list, handler.getDefaultValuesList(info));
    }

    @Test
    public void generateValuesFromDefaultValues_withValidOffsetLimit() {
        ListOrderedSet orderedSet = new ListOrderedSet();
        orderedSet.add("USA");
        orderedSet.add("Canada");
        orderedSet.add("Mexico");

        ReportInputControlInformation info = new JasperReportInputControlInformation();
        info.setDefaultValue(orderedSet);

        QueryValuesLoader valuesLoader = new QueryValuesLoader();
        handler.setLoader(valuesLoader);

        List<ListOfValuesItem> result = handler.generateValuesFromDefaultValues(info, 3, 2,1, "");
        assertEquals("Canada", result.get(0).getValue());
    }

    @Test
    public void SelectedValuesDict_withCollection() {

        List<Object> defaultValue = Arrays.asList(new Object[]{10.20, "String"});
        SingleSelectListInputControlHandler.SelectedValuesDict selectedValuesDict =  handler.createSelectedValuesDict(defaultValue);
        assertTrue(selectedValuesDict.checkMatch(10.20));
        assertTrue(selectedValuesDict.checkMatch("String"));
    }

    @Test
    public void SelectedValuesDict_withSingleIncomingValue() {

        Double defaultValue = 10.0;
        SingleSelectListInputControlHandler.SelectedValuesDict selectedValuesDict =  handler.createSelectedValuesDict(defaultValue);
        assertTrue(selectedValuesDict.checkMatch(10));

        doReturn("10").when(dataConverterService).formatSingleValue("10", null, (Class)null);
        assertFalse(selectedValuesDict.checkMatch("10"));

        doThrow(new IllegalStateException()).when(dataConverterService).formatSingleValue("invalid", null, (Class)null);
        assertFalse(selectedValuesDict.checkMatch("invalid"));


    }

    @Test
    public void SelectedValuesDict_withNullValue() {
        Object defaultValue = null;
        SingleSelectListInputControlHandler.SelectedValuesDict selectedValuesDict =  handler.createSelectedValuesDict(defaultValue);
        assertTrue(selectedValuesDict.checkMatch(null));

        defaultValue = "string";
        selectedValuesDict =  handler.createSelectedValuesDict(defaultValue);
        assertFalse(selectedValuesDict.checkMatch(null));

    }


    public List<ListOfValuesItem> getListOfValuesItem() {
        List<ListOfValuesItem> values = new ArrayList<>();
        ListOfValuesItem listOfValuesItem1 = new ListOfValuesItemImpl();
        ListOfValuesItem listOfValuesItem2 = new ListOfValuesItemImpl();
        ListOfValuesItem listOfValuesItem3 = new ListOfValuesItemImpl();

        listOfValuesItem1.setLabel("USA");
        listOfValuesItem1.setValue("USA");
        values.add(listOfValuesItem1);

        listOfValuesItem2.setLabel("Canada");
        listOfValuesItem2.setValue("Canada");
        values.add(listOfValuesItem2);

        listOfValuesItem3.setLabel("Mexico");
        listOfValuesItem3.setValue("Mexico");
        values.add(listOfValuesItem3);

        return values;
    }
}
