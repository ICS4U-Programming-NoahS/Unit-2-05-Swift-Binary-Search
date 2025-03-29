//
// BinarySearch.swift
//
// Created by Noah Smith
// Created on 2025-03-28
// Version 1.0
// Copyright (c) 2025 Noah Smith. All rights reserved.
//
// The Binary Search program will populate an array of 10 random numbers.
// Then it will sort it from smallest to largest.
// Then it will ask the user for a number to search for.
// If the number is found, it will display the index of the number.
// It will keep asking the user for a number to search for until the user enters "q".
// If the user enters "q", the program will display a goodbye message.

// Import foundation library
import Foundation

// Declare constants
let arrayLength = 10
let maxNum = 100

// Define the different possible error types
enum InputError: Error {
    case invalidInput
}

// Function to generate an array of random numbers
func populatingArrays() -> [Int] {
    // Create an array of numbers
    var arrayNum = [Int](repeating: 0, count: arrayLength)

    // Generate random numbers between 0 and 100
    for counter in 0..<arrayLength {
        arrayNum[counter] = Int.random(in: 0...maxNum)
    }

    // Sort and return the array
    return arrayNum.sorted()
}

// Function to find the index of the user's number
func binarySearch(arrayInt: [Int], userNumInt: Int) -> Int {

    // Initialize low and high outside of the loop
    var low = 0
    var high = arrayInt.count - 1

    // Perform a binary search on the sorted array to find the user's number
    // loop until index is returned or the low is greater than the high
    while low <= high {

        // calculate the mid
        let mid = low + (high - low) / 2

        // Check if user's number is equal to the mid
        if (arrayInt[mid] == userNumInt) {

            // return the index
            return mid

        // If the user number is greater, ignore left half of array
        }  else if (arrayInt[mid] < userNumInt) {
            // reset the low
            low = mid + 1

        // If the user's number is smaller, ignore right half of array
        }  else {
            // reset the high
            high = mid - 1
        }
    }

    // If we reach here, then the user's number is not found in the array
    return -1
    
}

// Greeting
print("Welcome to the binary search program!")

// Initialize user input outside the loop
var userNum = ""

// Keep looping until the user enters "q"
repeat {
    // Get the sorted array by calling the populating arrays function
    let arrayNumber = populatingArrays()

    // Instructions
    print("What number are you searching for in the list below? Enter 'q' to quit.")

    // Display the array
    for num in arrayNumber {

        // Terminator makes it so that all 10 numbers are all on one line
        print(num, terminator: " ")
    }

    // Ask the user for a number to search
    print("Number: ", terminator: "")

    // Get the user's number as a string
    // Got an error that said to force unwrap the readLine using '??'
    // If userNum is nil, it will default to an empty string
    userNum = readLine() ?? ""

    // If the user enters 'q'
    if userNum == "q" {
        print("Thank you for playing!")
    } else {
        // try to catch invalid input
        do {
            // Attempt to convert the user's input to an integer
            if let userNumInt = Int(userNum) {
                // Get the index of the user's number from function
                let index = binarySearch(arrayInt: arrayNumber, userNumInt: userNumInt)

                // if number is not found in array
                if (index == -1) {
                    print("\(userNumInt) is not in the array.")
                } else {
                    print("\(userNumInt) is found at index \(index).")
                }
            } else {
                // If user does not enter an integer
                throw InputError.invalidInput
            }
        } catch InputError.invalidInput {
            // If user does not enter an integer
            print("\(userNum) is not an integer.")
        }
    }

// Keep looping until the user enters "q"
} while userNum != "q"
