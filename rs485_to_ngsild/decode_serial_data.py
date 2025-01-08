from dataclasses import dataclass

# Define the type1 struct using a dataclass
@dataclass
class type1_serial_data:
    as7341_ADF2: int
    as7341_ADF4: int
    as7341_ADF3: int
    as7341_ADF5: int
    as7341_ADF7: int
    as7341_ADF8: int
    as7341_ADCLEAR: int
    as7341_ADF6: int
    as7341_ADNIR: int
    weight_in_gr: float

# Function to parse the input string
def parse_input_type1(input_string):
    
    occurrences = input_string.count('#')
    
    if not occurrences == 2:
        raise ValueError("Input string must have 2 #.")
    
    first_hash = input_string.find('#')
    last_hash = input_string.rfind('#')
    
    input_string=input_string[first_hash :last_hash+1]
    # print(input_string)
    # Ensure the string starts with #1 and ends with #
    if not input_string.startswith("#1") or not input_string.endswith("#"):
        raise ValueError("Input string must start with '#1' and end with '#'.")

    # Split the input string into parts
    values = input_string.strip("#").split(";")

    # Ensure there are exactly 11 fields (1 ID + 10 values)
    if len(values) != 11:
        raise ValueError("Input string must contain exactly 11 fields.")
    type1_data=type1_serial_data(0,0,0,0,0,0,0,0,0,0)
    # Extract weight_in_gr
    try:
        type1_data.weight_in_gr = float(values[1])
    except ValueError:
        raise ValueError("Weight must be a valid floating-point number.")

    # Ensure all remaining values are integers
    try:
        as7341_values = [int(value) for value in values[2:]]
    except ValueError:
        raise ValueError("Sensor values must be valid integers.")

    # Create an AS7341 instance
    type1_data.as7341_ADF2=as7341_values[0]
    type1_data.as7341_ADF4=as7341_values[1]
    type1_data.as7341_ADF3=as7341_values[2]
    type1_data.as7341_ADF5=as7341_values[3]
    type1_data.as7341_ADF7=as7341_values[4]
    type1_data.as7341_ADF8=as7341_values[5]
    type1_data.as7341_ADCLEAR=as7341_values[6]
    type1_data.as7341_ADF6=as7341_values[7]
    type1_data.as7341_ADNIR=as7341_values[8]
    

    return type1_data


if __name__ == "__main__":
    input_string = "#1;342.60;43;51;37;66;44;23;154;59;7#"
    type1_data = parse_input_type1(input_string)
    print(type1_data)