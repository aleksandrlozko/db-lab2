/* Zone populate */

INSERT INTO "Zone" ("RegName", "AreaName", "TerName", "TerTypeName")
SELECT DISTINCT REGNAME, AREANAME, TERNAME, TerTypeName
FROM TestTable;


INSERT INTO "Zone" ("RegName", "AreaName", "TerName")
SELECT DISTINCT EORegName, EOAreaName, EOTerName
FROM TestTable
WHERE EORegName IS NOT NULL AND EOAreaName IS NOT NULL AND EOTerName IS NOT NULL
EXCEPT
SELECT "RegName", "AreaName", "TerName"
FROM "Zone";

/* Educational objectives populate */

INSERT INTO "School" ("Name", "TypeName", "Parent", "ZoneID", "ClassLang")
SELECT DISTINCT on (TestTable.EONAME) TestTable.EONAME, TestTable.EOTYPENAME, TestTable.EOParent, "Region"."RegionID", TestTable.ClassLangName
FROM TestTable
LEFT JOIN "Region"
ON TestTable.EORegName = "Region"."RegName" AND TestTable.AreaName = "Region"."AreaName" AND TestTable.EOTerName = "Region"."TerName"
WHERE TestTable.EONAME IS NOT NULL;


INSERT INTO "School" ("EOName", "RegionID")
SELECT DISTINCT ON (zno.UkrPTName) zno.UkrPTName, "Region"."RegionID"
FROM TestTable
LEFT JOIN "Region"
ON TestTable.UkrPTRegName = "Region"."RegName" AND TestTable.UkrPTAreaName = "Region"."AreaName" AND TestTable.UkrPTTerName = "Region"."TerName"
WHERE TestTable.UkrPTName NOT IN (
SELECT "EOName"
FROM "School"
) AND TestTable.UkrPTName IS NOT NULL;


INSERT INTO "School" ("EOName", "RegionID")
SELECT DISTINCT ON (TestTable.histPTName) TestTable.histPTName, "Region"."RegionID"
FROM TestTable
LEFT JOIN "Region"
ON TestTable.histPTRegName = "Region"."RegName" AND TestTable.histPTAreaName = "Region"."AreaName" AND TestTable.histPTTerName = "Region"."TerName"
WHERE TestTable.histPTName NOT IN (
SELECT "EOName"
FROM "School"
) AND TestTable.histPTName IS NOT NULL;

INSERT INTO "School" ("EOName", "RegionID")
SELECT DISTINCT ON (TestTable.mathPTName) TestTable.mathPTName, "Region"."RegionID"
FROM TestTable
LEFT JOIN "Region"
ON TestTable.mathPTRegName = "Region"."RegName" AND TestTable.mathPTAreaName = "Region"."AreaName" AND TestTable.mathPTTerName = "Region"."TerName"
WHERE TestTable.mathPTName NOT IN (
SELECT "EOName"
FROM "School"
) AND TestTable.mathPTName IS NOT NULL;

INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (TestTable.histPTName) TestTable.physPTName, "Region"."RegionID"
FROM TestTable
LEFT JOIN "Region"
ON TestTable.physPTRegName = "Region"."RegName" AND TestTable.physPTAreaName = "Region"."AreaName" AND TestTable.physPTTerName = "Region"."TerName"
WHERE TestTable.physPTName NOT IN (
SELECT "EOName"
FROM "School"
) AND TestTable.physPTName IS NOT NULL;

INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (TestTable.chemPTName) TestTable.chemPTName, "Region"."RegionID"
FROM TestTable
LEFT JOIN "Region"
ON TestTable.chemPTRegName = "Region"."RegName" AND TestTable.chemPTAreaName = "Region"."AreaName" AND TestTable.chemPTTerName = "Region"."TerName"
WHERE TestTable.chemPTName NOT IN (
SELECT "EOName"
FROM "School"
) AND TestTable.chemPTName IS NOT NULL;


INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (TestTable.bioPTName) TestTable.bioPTName, "Region"."RegionID"
FROM TestTable
LEFT JOIN "Region"
ON TestTable.bioPTRegName = "Region"."RegName" AND TestTable.bioPTAreaName = "Region"."AreaName" AND TestTable.bioPTTerName = "Region"."TerName"
WHERE TestTable.bioPTName NOT IN (
SELECT "EOName"
FROM "School"
) AND TestTable.bioPTName IS NOT NULL;


INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (TestTable.geoPTName) TestTable.geoPTName, "Region"."RegionID"
FROM TestTable
LEFT JOIN "Region"
ON TestTable.geoPTRegName = "Region"."RegName" AND TestTable.geoPTAreaName = "Region"."AreaName" AND TestTable.geoPTTerName = "Region"."TerName"
WHERE TestTable.geoPTName NOT IN (
SELECT "EOName"
FROM "School"
) AND TestTable.geoPTName IS NOT NULL;


INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (zTestTableno.engPTName) TestTable.engPTName, "Region"."RegionID"
FROM TestTable
LEFT JOIN "Region"
ON TestTable.engPTRegName = "Region"."RegName" AND TestTable.engPTAreaName = "Region"."AreaName" AND TestTable.engPTTerName = "Region"."TerName"
WHERE TestTable.engPTName NOT IN (
SELECT "EOName"
FROM "School"
) AND TestTable.engPTName IS NOT NULL;


INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (TestTable.engPTName) TestTable.fraPTName, "Region"."RegionID"
FROM TestTable
LEFT JOIN "Region"
ON TestTable.fraPTRegName = "Region"."RegName" AND TestTable.fraPTAreaName = "Region"."AreaName" AND TestTable.fraPTTerName = "Region"."TerName"
WHERE TestTable.fraPTName NOT IN (
SELECT "EOName"
FROM "School"
) AND TestTable.fraPTName IS NOT NULL;

INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (TestTable.deuPTName) TestTable.deuPTName, "Region"."RegionID"
FROM TestTable
LEFT JOIN "Region"
ON TestTable.deuPTRegName = "Region"."RegName" AND TestTable.deuPTAreaName = "Region"."AreaName" AND TestTable.deuPTTerName = "Region"."TerName"
WHERE TestTable.deuPTName NOT IN (
SELECT "EOName"
FROM "School"
) AND TestTable.deuPTName IS NOT NULL;


INSERT INTO "EO" ("EOName", "RegionID")
SELECT DISTINCT ON (TestTable.spaPTName) TestTable.spaPTName, "Region"."RegionID"
FROM TestTable
LEFT JOIN "Region"
ON TestTable.spaPTRegName = "Region"."RegName" AND TestTable.spaPTAreaName = "Region"."AreaName" AND TestTable.spaPTTerName = "Region"."TerName"
WHERE TestTable.spaPTName NOT IN (
SELECT "EOName"
FROM "School"
) AND TestTable.spaPTName IS NOT NULL;




/* Person populate */

INSERT INTO "Person" ("PersonID", "Birth", "SexName", "RegionID", "RegTypeName", "ClassProfileName", "EOName")
SELECT TestTable.OUTID, TestTable.Birth, TestTable.SEXTYPENAME, "Region"."RegionID", TestTable.REGTYPENAME, TestTable.ClassProfileNAME, "School"."EOName"
FROM TestTable
LEFT JOIN "Zone"
ON TestTable.REGNAME = "Region"."RegName" AND TestTable.AREANAME = "Region"."AreaName" AND TestTable.TERNAME = "Region"."TerName"
LEFT JOIN "School"
ON TestTable.EONAME = "School"."EOName";



/* Exam populate */

INSERT INTO "Exam" ("OUTID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "AdaptScale", "PTEOName")
SELECT outID, UkrTest, zno_year, UkrTestStatus, UkrBall100, UkrBall12, UkrBall, UkrAdaptScale, UkrPTName
FROM TestTable
WHERE TestTable.UkrTest IS NOT NULL;



INSERT INTO "Exam" ("OUTID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName", "Lang")
SELECT outID, histTest, zno_year, histTestStatus, histBall100, histBall12, histBall, histPTName, histLang
FROM TestTable
WHERE TestTable.histTest IS NOT NULL;



INSERT INTO "Exam" ("OUTID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName", "Lang")
SELECT outID, mathTest, zno_year, mathTestStatus, mathBall100, mathBall12, mathBall, mathPTName, mathLang
FROM TestTable
WHERE TestTable.mathTest IS NOT NULL;


INSERT INTO "Exam" ("OUTID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName", "Lang")
SELECT outID, physTest, zno_year, physTestStatus, physBall100, physBall12, physBall, physPTName, physLang
FROM TestTable
WHERE TestTable.physTest IS NOT NULL;


INSERT INTO "Exam" ("OUTID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName", "Lang")
SELECT outID, chemTest, zno_year, chemTestStatus, chemBall100, chemBall12, chemBall, chemPTName, chemLang
FROM TestTable
WHERE TestTable.chemTest IS NOT NULL;



INSERT INTO "Exam" ("OUTID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName", "Lang")
SELECT outID, bioTest, zno_year, bioTestStatus, bioBall100, bioBall12, bioBall, bioPTName, bioLang
FROM TestTable
WHERE TestTable.bioTest IS NOT NULL;



INSERT INTO "Exam" ("OUTID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName", "Lang")
SELECT outID, geoTest, zno_year, geoTestStatus, geoBall100, geoBall12, geoBall, geoPTName, geoLang
FROM TestTable
WHERE TestTable.geoTest IS NOT NULL;


INSERT INTO "Exam" ("OUTID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName")
SELECT outID, engTest, zno_year, engTestStatus, engBall100, engBall12, engBall, engPTName
FROM TestTable
WHERE TestTable.engTest IS NOT NULL;


INSERT INTO "Exam" ("OUTID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName")
SELECT outID, fraTest, zno_year, fraTestStatus, fraBall100, fraBall12, fraBall, fraPTName
FROM TestTable
WHERE TestTable.fraTest IS NOT NULL;



INSERT INTO "Exam" ("OUTID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName")
SELECT outID, deuTest, zno_year, deuTestStatus, deuBall100, deuBall12, deuBall, deuPTName
FROM TestTable
WHERE TestTable.deuTest IS NOT NULL;



INSERT INTO "Exam" ("OUTID", "TestName", "Year", "TestStatus", "Ball100", "Ball12", "Ball", "PTEOName")
SELECT outID, spaTest, zno_year, spaTestStatus, spaBall100, spaBall12, spaBall, spaPTName
FROM TestTable
WHERE TestTable.spaTest IS NOT NULL;



