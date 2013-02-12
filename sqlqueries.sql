/*1. Write a query that returns all the IDs of providers in the Provider table whose specialty is “Cardiology”. */select ProviderIDfrom providerwhere specialty = 'Cardiology';/*2.Write a query that returns all the unique  Practice IDs of providers in the Provider table whose specialty is “Primary Care” or “Endocrinology”.*/select distinct PracticeIDfrom providerwhere specialty in ('Primary Care','Endocrinology');/*3.Write a query that returns the number of prescriptions in the Prescription table by BrandName*/select count(*) as PreCount, BrandNamefrom prescriptiongroup by BrandName;/* 4.Write a query that returns the total number of charts created by practice */select sum(numchartscreated) as ChartsCount, PracticeIDfrom providergroup by PracticeID;/*5.Write a query that returns the number of unique patients prescribed a medication by a provider whose specialty is “Primary Care” by  the medication's BrandName */select count(distinct s.patientid) as PatientCount, s.BrandNamefrom prescription sinner join provider p on p.providerid = s.provideridwhere p.specialty = 'Primary Care'group by s.brandname; /*6.	Let's say that providers who joined on or before 3/1/2011 are in Cohort A, that providers who joined between 3/2/2011 and 7/22/2012 inclusive are in Cohort B, and providers who joined on or after 7/22/2012 are in Cohort C. Write a query that returns the number of unique practices by cohort */select COUNT(distinct p.practiceid) as PracticeCount, p.CohortIDfrom (select providerid, practiceid, joindate, CASE       WHEN joindate <= '3/1/2011' THEN 'A'      when joindate < '7/22/2012' then 'B'     when joindate >= '7/22/2012' then 'C'END as CohortIDfrom provider) p group by p.CohortID/*7.	Write a query that returns the number of charts created by ProviderID for providers whose first prescription was Lipitor. Assume that sorting in descending order by PrescriptionID is the same as sorting by time of prescription.*/select p.ProviderID, p.NumChartsCreated, pr.BrandNamefrom provider pinner join (/* every provider's first prescription id   */	select MIN(prescriptionid) as id, providerid	from prescription 	group by providerid) f on f.providerid = p.providerid/* join to full prescription table for details */inner join prescription pr on pr.prescriptionid = f.idwhere pr.brandname = 'Lipitor'