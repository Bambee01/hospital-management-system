## Hospital Database Schema Documentation

This script sets up a comprehensive hospital management system with tables and relationships to manage physicians, departments, procedures, patients, appointments, medications, and other relevant information. Below are details of each component:

---

![photo_2024-10-30_16-39-56.jpg](assets/https://prod-files-secure.s3.us-west-2.amazonaws.com/19bec02c-7232-4876-8dcb-3cc5def4cf03/bbe22e31-7656-4776-a9e4-26ba0b611a11/photo_2024-10-30_16-39-56.jpg)

### 1. **Physician Table**

- **Columns:**
    - `employee_id`: Primary key.
    - `name`, `position`, `ssn`: Information about the physician.
- **Purpose:** Stores physician details.

### 2. **Department Table**

- **Columns:**
    - `DepartmentID`: Primary key.
    - `Name`, `Head`: Department information.
- **Purpose:** Stores hospital departments.

### 3. **Affiliated_With Table**

- **Columns:**
    - `Physician`: Foreign key referencing `Physician(employee_id)`.
    - `Department`: Foreign key referencing `Department(DepartmentID)`.
    - `PrimaryAffiliation`: Specifies the primary affiliation status.
- **Purpose:** Links physicians with their affiliated departments.

### 4. **GetPhysicianByDepartment Function**

- **Parameter:** `@department_id`: Department ID.
- **Returns:** Table of physicians associated with the specified department.

### 5. **ProcedureS Table**

- **Columns:**
    - `Code`: Primary key.
    - `Name`, `Cost`: Details about the procedure.
- **Purpose:** Stores information about medical procedures.

### 6. **Trained_In Table**

- **Columns:**
    - `Physician`: Foreign key to `Physician(employee_id)`.
    - `Treatment`: Foreign key to `ProcedureS(Code)`.
    - `CertificationDate`, `CertificationExpires`: Certification details.
- **Purpose:** Tracks procedures physicians are certified to perform.

### 7. **Patient Table**

- **Columns:**
    - `SSN`: Primary key.
    - `Name`, `Address`, `Phone`, `InsuranceID`, `PCP`: Personal information, including a foreign key `PCP` to `Physician(employee_id)`.
- **Purpose:** Stores patient details.

### 8. **Nurse Table**

- **Columns:**
    - `EmployeeID`: Primary key.
    - `Name`, `Position`, `Registered`, `SSN`: Nurse details.
- **Purpose:** Stores nurse information.

### 9. **Appointment Table**

- **Columns:**
    - `AppointmentID`: Primary key.
    - `Patient`: Foreign key to `Patient(SSN)`.
    - `PrepNurse`: Foreign key to `Nurse(EmployeeID)`.
    - `Physician`: Foreign key to `Physician(employee_id)`.
    - `Start_dt_time`, `End_dt_time`, `ExaminationRoom`: Appointment details.
- **Purpose:** Manages patient appointments.

### 10. **Medication Table**

- **Columns:**
    - `Code`: Primary key.
    - `Name`, `Brand`, `Description`: Medication information.
- **Purpose:** Stores medication details.

### 11. **Prescribes Table**

- **Columns:**
    - `Physician`, `Patient`, `Medication`: Foreign keys to `Physician(employee_id)`, `Patient(SSN)`, and `Medication(Code)`.
    - `Date`, `Appointment`, `Dose`: Prescription details.
- **Purpose:** Tracks medication prescriptions for patients.

### 12. **Block Table**

- **Columns:**
    - `Floor`, `Code`: Composite primary key.
- **Purpose:** Defines blocks within the hospital.

### 13. **Room Table**

- **Columns:**
    - `Number`: Primary key.
    - `Type`, `BlockFloor`, `BlockCode`, `Unavailable`: Room details, with foreign key to `Block`.
- **Purpose:** Manages room information.

### 14. **On_Call Table**

- **Columns:**
    - `Nurse`, `BlockFloor`, `BlockCode`: Foreign keys referencing `Nurse(EmployeeID)` and `Block`.
    - `on_call_start`, `on_call_end`: On-call shift times.
- **Purpose:** Tracks nurses’ on-call shifts.

### 15. **Stay Table**

- **Columns:**
    - `StayID`: Primary key.
    - `Patient`: Foreign key to `Patient(SSN)`.
    - `Room`: Foreign key to `Room(Number)`.
    - `Start_dt_time`, `End_dt_time`: Stay details.
- **Purpose:** Tracks patient stays in hospital rooms.

### 16. **Undergoes Table**

- **Columns:**
    - `Patient`, `Procedures`, `Stay`: Foreign keys to `Patient(SSN)`, `ProcedureS(Code)`, and `Stay(StayID)`.
    - `Date`, `Physician`, `AssistingNurse`: Procedure details with foreign keys to `Physician(employee_id)` and `Nurse(EmployeeID)`.
- **Purpose:** Manages procedures undergone by patients during stays.

---

Each table and relationship is designed to efficiently manage hospital operations and ensure data consistency across multiple entities.

---

### 1. **dbo.ScheduleAppointment Stored Procedure**

- **Parameters:**
    - `@p_patient_id`: Patient’s ID (foreign key to `Patient` table).
    - `@p_prenurse`: ID of the nurse assigned to prepare the patient (foreign key to `Nurse` table).
    - `@p_physician`: Physician’s ID for the appointment (foreign key to `Physician` table).
    - `@p_start_time`: Appointment start time.
    - `@p_end_time`: Appointment end time.
    - `@p_examroom`: Room assigned for the examination.
- **Purpose:** Schedules an appointment for a patient with specified physician and nurse in the provided room and time slots by inserting a record into the `Appointment` table.

---

### 2. **dbo.addnewpatient Stored Procedure**

- **Parameters:**
    - `@ssn`: Social Security Number of the new patient (primary key in `Patient` table).
    - `@name`: Patient’s name.
    - `@address`: Patient’s address.
    - `@phone`: Patient’s phone number.
    - `@insurance_id`: Insurance ID number of the patient.
    - `@pcp`: ID of the primary care physician assigned to the patient (foreign key to `Physician` table).
- **Purpose:** Adds a new patient to the `Patient` table with all necessary personal and medical information.

---

These procedures streamline data entry, ensuring that scheduling and patient onboarding can be done through single calls to the database, reducing redundancy and maintaining consistency across related tables.
