import pytest
import decode_serial_data


def test_valid_input():
    input_string = "#1;342.60;43;51;37;66;44;23;154;59;7#"
    type1_data = decode_serial_data.parse_input_type1(input_string)
    assert type1_data.weight_in_gr == 342.60
    assert type1_data.as7341_ADF2 == 43
    assert type1_data.as7341_ADF4 == 51
    assert type1_data.as7341_ADF3 == 37
    assert type1_data.as7341_ADF5 == 66
    assert type1_data.as7341_ADF7 == 44
    assert type1_data.as7341_ADF8 == 23
    assert type1_data.as7341_ADCLEAR == 154
    assert type1_data.as7341_ADF6 == 59
    assert type1_data.as7341_ADNIR == 7

def test_invalid_start():
    input_string = "#2;342.60;43;51;37;66;44;23;154;59;7#"
    with pytest.raises(ValueError, match="Input string must start with '#1' and end with '#'"):
        decode_serial_data.parse_input_type1(input_string)

def test_invalid_end():
    input_string = "#1;342.60;43;51;37;66;44;23;154;59;7"
    with pytest.raises(ValueError, match="Input string must start with '#1' and end with '#'"):
        decode_serial_data.parse_input_type1(input_string)

def test_incorrect_field_count():
    input_string = "#1;342.60;43;51;37;66;44;23;154;59#"
    with pytest.raises(ValueError, match="Input string must contain exactly 11 fields"):
        decode_serial_data.parse_input_type1(input_string)

def test_invalid_weight():
    input_string = "#1;invalid;43;51;37;66;44;23;154;59;7#"
    with pytest.raises(ValueError, match="Weight must be a valid floating-point number"):
        decode_serial_data.parse_input_type1(input_string)

def test_invalid_sensor_value():
    input_string = "#1;342.60;43;51;37;66;invalid;23;154;59;7#"
    with pytest.raises(ValueError, match="Sensor values must be valid integers"):
        decode_serial_data.parse_input_type1(input_string)
