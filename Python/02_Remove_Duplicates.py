def remove_duplicate_words():
    input_string = input("Enter a sentence to remove duplicate words: ")
    
    words = input_string.split()
    seen = set()
    result = []
    
    for word in words:
        # We use .lower() for the comparison to catch duplicates 
        # regardless of case, but you can remove it if case matters.
        if word.lower() not in seen:
            result.append(word)
            seen.add(word.lower())
    
    cleaned_string = " ".join(result)
    print(f"Cleaned Sentence: {cleaned_string}")

if __name__ == "__main__":
    remove_duplicate_words()