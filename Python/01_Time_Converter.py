def convert_minutes():
    try:
        total_minutes = int(input("Enter the number of minutes to convert: "))
        
        # Calculate days, remaining hours, and remaining minutes
        days = total_minutes // (24 * 60)
        remaining_minutes = total_minutes % (24 * 60)
        hours = remaining_minutes // 60
        minutes = remaining_minutes % 60
        
        print(f"Result (Days:Hours:Minutes): {days}:{hours}:{minutes}")
    except ValueError:
        print("Please enter a valid whole number.")

if __name__ == "__main__":
    convert_minutes()