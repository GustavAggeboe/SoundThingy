# Machine Learning - Sound

> **Note:** This project serves as **documentation** of my **learning journey** and is not intended for ongoing use or maintenance.
> I've decided to keep the repository public to be viewed as part of my portfolio.

<br>

This project demonstrates machine learning techniques using Processing and Wekinator to generate five distinct tones. The approach uses a camera as the input device, capturing 400 grayscale pixels that serve as the data for training the model.

This project was developed to familiarize myself with the basics of machine learning as an introductory learning experience. It allowed me to explore the fundamentals of machine learning techniques.

## Overview

- **Input:** The model uses the camera's grayscale pixel data (400 pixels) as input.
- **Model Training:** The model is trained using a 3-Nearest Neighbor (3-NN) algorithm, a classification technique chosen for its effective performance during testing.
- **Output Classes:** The training process assigns different output classes based on the input location. Specifically, output class 1 is reserved for the default state, where the Processing program sets the frequency to 0 Hz—resulting in a tone that is too low to be audible. Output classes 2 through 6 are mapped to specific tones.

## Tone Frequencies

The following tones and their corresponding frequencies are defined for output classes 2 to 6:

- **C:** 523.25 Hz  
- **G:** 783.99 Hz  
- **High C:** 1046.50 Hz  
- **D:** 1174.66 Hz  
- **E:** 1318.51 Hz  

## Implementation Details

- **Machine Learning Framework:** Wekinator is used to implement the machine learning model.
- **Programming Environment:** The project is developed using Processing, integrating machine learning output with real-time audio generation.
- **Classification Method:** A 3-Nearest Neighbor classifier is employed to map the camera input to the appropriate tone outputs. This method was selected based on its superior performance during preliminary tests.
