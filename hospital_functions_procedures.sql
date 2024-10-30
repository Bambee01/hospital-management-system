
CREATE PROCEDURE dbo.ScheduleAppointment
     @p_patient_id INT,
     @p_prenurse INT,
     @p_physician INT,
     @p_start_time datetime,
     @p_end_time datetime,
     @p_examroom varchar(255)
as
BEGIN
    INSERT INTO appointment (patient, prenurse, physician, start_dt_time, end_dt_time, examinationroom)
    VALUES (@p_patient_id, @p_prenurse, @p_physician, @p_start_time, @p_end_time, @p_examroom);
END;


create procedure dbo.addnewpatient
    @ssn int,
    @name varchar(255),
    @address varchar(255),
    @phone varchar(255),
    @insurance_id int,
    @pcp int,
as
begin 
      insert into Patient (SSN,Name,Address,Phone,InsuranceID,PCP)
    values (@ssn,@name,@address,@phone,@insurance_id,@pcp);
end;