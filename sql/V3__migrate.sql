/*-Zone-*/

INSERT INTO Zone (RegName,
                  AreaName,
                  TerName,
                  TerTypeName)
SELECT DISTINCT Regname,
                AreaName,
                TerName,
                TerTypeName
FROM TestTable
ON CONFLICT DO NOTHING;


INSERT INTO Zone (RegName,
                  AreaName,
                  TerName)
SELECT DISTINCT EORegName,
                EOAreaName,
                EOTerName
FROM TestTable
ON CONFLICT DO NOTHING;



/*-School-*/

INSERT INTO School (ZoneID,
                    Name,
                    TypeName,
                    Parent)
SELECT DISTINCT (SELECT ZoneID
                 FROM Zone as area
                 WHERE tt.EORegName = area.RegName
                   AND tt.EOAreaName = area.AreaName
                   AND tt.EOTerName = area.TerName) as area,
                tt.EOName,
                tt.EOTypeName,
                tt.EOParent
FROM TestTable as tt ON CONFLICT DO NOTHING;


INSERT INTO School (ZoneID, Name)
SELECT DISTINCT (SELECT ZoneID
                 FROM Zone as area
                 WHERE tt.UkrPTRegName = area.RegName
                   AND tt.UkrPTAreaName = area.AreaName
                   AND tt.UkrPTTerName = area.TerName) as area,
                tt.UkrPTName
FROM TestTable as tt ON CONFLICT DO NOTHING;

INSERT INTO School (ZoneID, Name)
SELECT DISTINCT (SELECT ZoneID
                 FROM Zone as area
                 WHERE tt.histPTRegName = area.RegName
                   AND tt.histPTAreaName = area.AreaName
                   AND tt.histPTTerName = area.TerName) as area,
                tt.histPTName
FROM TestTable as tt ON CONFLICT DO NOTHING;

INSERT INTO School (ZoneID, Name)
SELECT DISTINCT (SELECT ZoneID
                 FROM Zone as area
                 WHERE tt.mathPTRegName = area.RegName
                   AND tt.mathPTAreaName = area.AreaName
                   AND tt.mathPTTerName = area.TerName) as area,
                tt.mathPTName
FROM TestTable as tt ON CONFLICT DO NOTHING;

INSERT INTO School (ZoneID, Name)
SELECT DISTINCT (SELECT ZoneID
                 FROM Zone as area
                 WHERE tt.physPTRegName = area.RegName
                   AND tt.physPTAreaName = area.AreaName
                   AND tt.physPTTerName = area.TerName) as area,
                tt.physPTName
FROM TestTable as tt ON CONFLICT DO NOTHING;

INSERT INTO School (ZoneID, Name)
SELECT DISTINCT (SELECT ZoneID
                 FROM Zone as area
                 WHERE tt.chemPTRegName = area.RegName
                   AND tt.chemPTAreaName = area.AreaName
                   AND tt.chemPTTerName = area.TerName) as area,
                tt.chemPTName
FROM TestTable as tt ON CONFLICT DO NOTHING;

INSERT INTO School (ZoneID, Name)
SELECT DISTINCT (SELECT ZoneID
                 FROM Zone as area
                 WHERE tt.bioPTRegName = area.RegName
                   AND tt.bioPTAreaName = area.AreaName
                   AND tt.bioPTTerName = area.TerName) as area,
                tt.bioPTName
FROM TestTable as tt ON CONFLICT DO NOTHING;

INSERT INTO School (ZoneID, Name)
SELECT DISTINCT (SELECT ZoneID
                 FROM Zone as area
                 WHERE tt.geoPTRegName = area.RegName
                   AND tt.geoPTAreaName = area.AreaName
                   AND tt.geoPTTerName = area.TerName) as area,
                tt.geoPTName
FROM TestTable as tt ON CONFLICT DO NOTHING;

INSERT INTO School (ZoneID,
                    Name)
SELECT DISTINCT (SELECT ZoneID
                 FROM Zone as area
                 WHERE tt.engPTRegName = area.RegName
                   AND tt.engPTAreaName = area.AreaName
                   AND tt.engPTTerName = area.TerName) as area,
                tt.engPTName
FROM TestTable as tt ON CONFLICT DO NOTHING;

INSERT INTO School (ZoneID,
                    Name)
SELECT DISTINCT (SELECT ZoneID
                 FROM Zone as area
                 WHERE tt.fraPTRegName = area.RegName
                   AND tt.fraPTAreaName = area.AreaName
                   AND tt.fraPTTerName = area.TerName) as area,
                tt.fraPTName
FROM TestTable as tt ON CONFLICT DO NOTHING;

INSERT INTO School (ZoneID,
                    Name)
SELECT DISTINCT (SELECT ZoneID
                 FROM Zone as area
                 WHERE tt.deuPTRegName = area.RegName
                   AND tt.deuPTAreaName = area.AreaName
                   AND tt.deuPTTerName = area.TerName) as area,
                tt.deuPTName
FROM TestTable as tt ON CONFLICT DO NOTHING;

INSERT INTO School (ZoneID,
                    Name)
SELECT DISTINCT (SELECT ZoneID
                 FROM Zone as area
                 WHERE tt.spaPTRegName = area.RegName
                   AND tt.spaPTAreaName = area.AreaName
                   AND tt.spaPTTerName = area.TerName) as area,
                tt.spaPTName
FROM TestTable as tt ON CONFLICT DO NOTHING;



/*-Student-*/

INSERT INTO Student (OUTID,
                     ExamYear,
                     Birth,
                     SexTypeName,
                     RegTypeName,
                     ClassProfileName,
                     ClassLangName,
                     ZoneID,
                     SchoolID)
SELECT OUTID,
       ExamYear,
       Birth,
       SexTypeName,
       RegTypeName,
       ClassProfileName,
       ClassLangName,
       (SELECT ZoneID
        FROM Zone as area
        WHERE tt.RegName = area.RegName
          AND tt.AreaName = area.AreaName
          AND tt.TerName = area.TerName) as area,
       (SELECT SchoolID
        FROM School as school
        WHERE tt.EOName = school.Name)   as school
FROM TestTable as tt;



/*-DPA-*/

INSERT INTO DPA (DPALevel)
SELECT DISTINCT UkrTest
FROM TestTable
ON CONFLICT DO NOTHING;

INSERT INTO DPA (DPALevel)
SELECT DISTINCT histTest
FROM TestTable
ON CONFLICT DO NOTHING;

INSERT INTO DPA (DPALevel)
SELECT DISTINCT mathTest
FROM TestTable
ON CONFLICT DO NOTHING;

INSERT INTO DPA (DPALevel)
SELECT DISTINCT physTest
FROM TestTable
ON CONFLICT DO NOTHING;

INSERT INTO DPA (DPALevel)
SELECT DISTINCT chemTest
FROM TestTable
ON CONFLICT DO NOTHING;

INSERT INTO DPA (DPALevel)
SELECT DISTINCT bioTest
FROM TestTable
ON CONFLICT DO NOTHING;

INSERT INTO DPA (DPALevel)
SELECT DISTINCT geoTest
FROM TestTable
ON CONFLICT DO NOTHING;

INSERT INTO DPA (DPALevel)
SELECT DISTINCT engTest
FROM TestTable
ON CONFLICT DO NOTHING;

INSERT INTO DPA (DPALevel)
SELECT DISTINCT fraTest
FROM TestTable
ON CONFLICT DO NOTHING;

INSERT INTO DPA (DPALevel)
SELECT DISTINCT deuTest
FROM TestTable
ON CONFLICT DO NOTHING;

INSERT INTO DPA (DPALevel)
SELECT DISTINCT spaTest
FROM TestTable
ON CONFLICT DO NOTHING;



/*-Exam-*/

INSERT INTO Exam (OUTID,
                  TestName,
                  School,
                  TestStatus,
                  Ball100,
                  Ball12,
                  Ball,
                  AdaptScale)
SELECT tt.OUTID,
       (SELECT DPALevelID FROM DPA WHERE Test = tt.UkrTest) as subject,
       (SELECT SchoolID from School WHERE Name = tt.UkrPTName) as school,
       UkrTestStatus,
       UkrBall100,
       UkrBall12,
       UkrBall,
       UkrAdaptScale

FROM TestTable as tt
WHERE tt.UkrTest IS NOT NULL
   OR tt.UkrTestStatus IS NOT NULL
   OR tt.UkrPTName IS NOT NULL
   OR tt.UkrPTRegName IS NOT NULL
   OR tt.UkrPTAreaName IS NOT NULL
   OR tt.UkrPTTerName IS NOT NULL
   OR tt.UkrBall100 IS NOT NULL
   OR tt.UkrBall12 IS NOT NULL
   OR tt.UkrBall IS NOT NULL;

INSERT INTO Exam (OUTID,
                  TestName,
                  School,
                  TestStatus,
                  Ball100,
                  Ball12,
                  Ball)
SELECT tt.OUTID,
       (SELECT DPALevelID FROM DPA WHERE Test = tt.histTest) as subject,
       (SELECT SchoolID from School WHERE Name = tt.histPTName) as school,
       histTestStatus,
       histBall100,
       histBall12,
       histBall

FROM TestTable as tt
WHERE tt.histTest IS NOT NULL
   OR tt.histTestStatus IS NOT NULL
   OR tt.histPTName IS NOT NULL
   OR tt.histPTRegName IS NOT NULL
   OR tt.histPTAreaName IS NOT NULL
   OR tt.histPTTerName IS NOT NULL
   OR tt.histBall100 IS NOT NULL
   OR tt.histBall12 IS NOT NULL
   OR tt.histBall IS NOT NULL;


INSERT INTO Exam (OUTID,
                  TestName,
                  School,
                  TestStatus,
                  Ball100,
                  Ball12,
                  Ball)
SELECT tt.OUTID,
       (SELECT DPALevelID FROM DPA WHERE Test = tt.mathTest) as subject,
       (SELECT SchoolID from School WHERE Name = tt.mathPTName) as school,
       mathTestStatus,
       mathBall100,
       mathBall12,
       mathBall

FROM TestTable as tt
WHERE tt.mathTest IS NOT NULL
   OR tt.mathTestStatus IS NOT NULL
   OR tt.mathPTName IS NOT NULL
   OR tt.mathPTRegName IS NOT NULL
   OR tt.mathPTAreaName IS NOT NULL
   OR tt.mathPTTerName IS NOT NULL
   OR tt.mathBall100 IS NOT NULL
   OR tt.mathBall12 IS NOT NULL
   OR tt.mathBall IS NOT NULL;


INSERT INTO Exam (OUTID,
                  TestName,
                  School,
                  TestStatus,
                  Ball100,
                  Ball12,
                  Ball)
SELECT tt.OUTID,
       (SELECT DPALevelID FROM DPA WHERE Test = tt.physTest) as subject,
       (SELECT SchoolID from School WHERE Name = tt.physPTName) as school,
       physTestStatus,
       physBall100,
       physBall12,
       physBall

FROM TestTable as tt
WHERE tt.physTest IS NOT NULL
   OR tt.physTestStatus IS NOT NULL
   OR tt.physPTName IS NOT NULL
   OR tt.physPTRegName IS NOT NULL
   OR tt.physPTAreaName IS NOT NULL
   OR tt.physPTTerName IS NOT NULL
   OR tt.physBall100 IS NOT NULL
   OR tt.physBall12 IS NOT NULL
   OR tt.physBall IS NOT NULL;


INSERT INTO Exam (OUTID,
                  TestName,
                  School,
                  TestStatus,
                  Ball100,
                  Ball12,
                  Ball)
SELECT tt.OUTID,
       (SELECT DPALevelID FROM DPA WHERE Test = tt.chemTest) as subject,
       (SELECT SchoolID from School WHERE Name = tt.chemPTName) as school,
       chemTestStatus,
       chemBall100,
       chemBall12,
       chemBall

FROM TestTable as tt
WHERE tt.chemTest IS NOT NULL
   OR tt.chemTestStatus IS NOT NULL
   OR tt.chemPTName IS NOT NULL
   OR tt.chemPTRegName IS NOT NULL
   OR tt.chemPTAreaName IS NOT NULL
   OR tt.chemPTTerName IS NOT NULL
   OR tt.chemBall100 IS NOT NULL
   OR tt.chemBall12 IS NOT NULL
   OR tt.chemBall IS NOT NULL;


INSERT INTO Exam (OUTID,
                  TestName,
                  School,
                  TestStatus,
                  Ball100,
                  Ball12,
                  Ball)
SELECT tt.OUTID,
       (SELECT DPALevelID FROM DPA WHERE Test = tt.bioTest) as subject,
       (SELECT SchoolID from School WHERE Name = tt.bioPTName) as school,
       bioTestStatus,
       bioBall100,
       bioBall12,
       bioBall

FROM TestTable as tt
WHERE tt.bioTest IS NOT NULL
   OR tt.bioTestStatus IS NOT NULL
   OR tt.bioPTName IS NOT NULL
   OR tt.bioPTRegName IS NOT NULL
   OR tt.bioPTAreaName IS NOT NULL
   OR tt.bioPTTerName IS NOT NULL
   OR tt.bioBall100 IS NOT NULL
   OR tt.bioBall12 IS NOT NULL
   OR tt.bioBall IS NOT NULL;


INSERT INTO Exam (OUTID,
                  TestName,
                  School,
                  TestStatus,
                  Ball100,
                  Ball12,
                  Ball)
SELECT tt.OUTID,
       (SELECT DPALevelID FROM DPA WHERE Test = tt.geoTest) as subject,
       (SELECT SchoolID from School WHERE Name = tt.geoPTName) as school,
       geoTestStatus,
       geoBall100,
       geoBall12,
       geoBall

FROM TestTable as tt
WHERE tt.geoTest IS NOT NULL
   OR tt.geoTestStatus IS NOT NULL
   OR tt.geoPTName IS NOT NULL
   OR tt.geoPTRegName IS NOT NULL
   OR tt.geoPTAreaName IS NOT NULL
   OR tt.geoPTTerName IS NOT NULL
   OR tt.geoBall100 IS NOT NULL
   OR tt.geoBall12 IS NOT NULL
   OR tt.geoBall IS NOT NULL;

INSERT INTO Exam (OUTID,
                  TestName,
                  School,
                  TestStatus,
                  Ball100,
                  Ball12,
                  Ball,
                  DPALevel)
SELECT tt.OUTID,
       (SELECT DPALevelID FROM DPA WHERE Test = tt.engTest) as subject,
       (SELECT SchoolID from School WHERE Name = tt.engPTName) as school,
       engTestStatus,
       engBall100,
       engBall12,
       engBall,
       engDPALevel

FROM TestTable as tt
WHERE tt.engTest IS NOT NULL
   OR tt.engTestStatus IS NOT NULL
   OR tt.engPTName IS NOT NULL
   OR tt.engPTRegName IS NOT NULL
   OR tt.engPTAreaName IS NOT NULL
   OR tt.engPTTerName IS NOT NULL
   OR tt.engBall100 IS NOT NULL
   OR tt.engBall12 IS NOT NULL
   OR tt.engBall IS NOT NULL;


INSERT INTO Exam (OUTID,
                  TestName,
                  School,
                  TestStatus,
                  Ball100,
                  Ball12,
                  Ball,
                  DPALevel)
SELECT tt.OUTID,
       (SELECT DPALevelID FROM DPA WHERE Test = tt.fraTest) as subject,
       (SELECT SchoolID from School WHERE Name = tt.fraPTName) as school,
       fraTestStatus,
       fraBall100,
       fraBall12,
       fraBall,
       fraDPALevel

FROM TestTable as tt
WHERE tt.fraTest IS NOT NULL
   OR tt.fraTestStatus IS NOT NULL
   OR tt.fraPTName IS NOT NULL
   OR tt.fraPTRegName IS NOT NULL
   OR tt.fraPTAreaName IS NOT NULL
   OR tt.fraPTTerName IS NOT NULL
   OR tt.fraBall100 IS NOT NULL
   OR tt.fraBall12 IS NOT NULL
   OR tt.fraBall IS NOT NULL;


INSERT INTO Exam (OUTID,
                  TestName,
                  School,
                  TestStatus,
                  Ball100,
                  Ball12,
                  Ball,
                  DPALevel)
SELECT tt.OUTID,
       (SELECT DPALevelID FROM DPA WHERE Test = tt.deuTest) as subject,
       (SELECT SchoolID from School WHERE Name = tt.deuPTName) as school,
       deuTestStatus,
       deuBall100,
       deuBall12,
       deuBall,
       deuDPALevel

FROM TestTable as tt
WHERE tt.deuTest IS NOT NULL
   OR tt.deuTestStatus IS NOT NULL
   OR tt.deuPTName IS NOT NULL
   OR tt.deuPTRegName IS NOT NULL
   OR tt.deuPTAreaName IS NOT NULL
   OR tt.deuPTTerName IS NOT NULL
   OR tt.deuBall100 IS NOT NULL
   OR tt.deuBall12 IS NOT NULL
   OR tt.deuBall IS NOT NULL;


INSERT INTO Exam (OUTID,
                  TestName,
                  School,
                  TestStatus,
                  Ball100,
                  Ball12,
                  Ball,
                  DPALevel)
SELECT tt.OUTID,
       (SELECT DPALevelID FROM DPA WHERE Test = tt.spaTest) as subject,
       (SELECT SchoolID from School WHERE Name = tt.spaPTName) as school,
       spaTestStatus,
       spaBall100,
       spaBall12,
       spaBall,
       spaDPALevel

FROM TestTable as tt
WHERE tt.spaTest IS NOT NULL
   OR tt.spaTestStatus IS NOT NULL
   OR tt.spaPTName IS NOT NULL
   OR tt.spaPTRegName IS NOT NULL
   OR tt.spaPTAreaName IS NOT NULL
   OR tt.spaPTTerName IS NOT NULL
   OR tt.spaBall100 IS NOT NULL
   OR tt.spaBall12 IS NOT NULL
   OR tt.spaBall IS NOT NULL;
   
   
   
/*-DROP-*/

DROP TABLE TestTable;
