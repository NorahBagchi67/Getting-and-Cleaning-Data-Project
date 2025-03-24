# CodeBook
This document describes the dataset variables and transformations.

## Variables
- `subject`: ID of the subject who performed the activity.
- `activity`: The type of activity (e.g., Walking, Sitting).
- Other variables: Measurements from the accelerometer and gyroscope.

## Transformations
1. Merged training and test datasets.
2. Extracted only mean and standard deviation measurements.
3. Renamed columns for readability.
4. Created an independent dataset with averages per activity and subject.
