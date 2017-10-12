USER mapd mapd
SELECT cast((cast(c3_START as float) - 52) * 4.012193408842492e-7 as int) as key0,AVG(AF) AS afavg FROM mgrb WHERE (c3_START >= 52 AND c3_START <= 249240280) AND AF IS NOT NULL GROUP BY key0 HAVING key0 >= 0 AND key0 < 100 ORDER BY key0;
SELECT * FROM MGRB WHERE (chromosome = '2') AND (ALT = 'T') AND (c4_REF = 'C') AND ((AF >= 0.9166666666666666 AND AF <= 1)) LIMIT 20 OFFSET 0;
SELECT * FROM MGRB WHERE (clinvar = 'UncertainSignificance') AND (consequences = 'missense_variant') AND ((gnomadAF >= 0 AND gnomadAF <= 0.1)) AND (polyPhen = 'benign') AND (sift = 'tolerated') AND ((eigen >= -0.933333333333334 AND eigen <= -0.4666666666666674)) LIMIT 20 OFFSET 0;
