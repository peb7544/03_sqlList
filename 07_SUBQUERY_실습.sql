-- 1. 전지연 사원이 속해있는 부서원들을 조회하시오 (단, 전지연은 제외)
--    사번, 사원명, 전화번호, 고용일, 부서명

SELECT 
	 EMP_ID
	,EMP_NAME 
	,PHONE 
	,TO_CHAR(HIRE_DATE, 'YY/MM/DD') HIRE_DATE
	,DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '전지연')
AND EMP_NAME != '전지연';

----------------------------------------------------------------------------

SELECT 
	 EMP_ID
	,EMP_NAME 
	,PHONE 
	,HIRE_DATE
	,DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '전지연');
AND EMP_NAME != '전지연';


-- 2. 고용일이 2000년도 이후인 사원들 중 급여가 가장 높은 사원의
--    사번, 사원명, 전화번호, 급여, 직급명을 조회하시오.

SELECT 
	 EMP_ID 
	,EMP_NAME 
	,PHONE 
	,SALARY
	,JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE WHERE EXTRACT(YEAR FROM HIRE_DATE) >= '2000');

-- 3. 노옹철 사원과 같은 부서, 같은 직급인 사원을 조회하시오. (단, 노옹철 사원은 제외)
--    사번, 이름, 부서코드, 직급코드, 부서명, 직급명

SELECT 
	 EMP_ID
	,EMP_NAME 
	,DEPT_CODE 
	,JOB_CODE 
	,DEPT_TITLE
	,JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '노옹철')
AND EMP_NAME != '노옹철';

--------------------------------------------------------------------------------------------------

SELECT 
	 EMP_ID
	,EMP_NAME 
	,DEPT_CODE 
	,JOB_CODE 
	,DEPT_TITLE
	,JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
NATURAL JOIN JOB
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '노옹철')
AND EMP_NAME != '노옹철';

-- 4. 2000년도에 입사한 사원과 부서와 직급이 같은 사원을 조회하시오
--    사번, 이름, 부서코드, 직급코드, 고용일

SELECT 
	 EMP_ID
	,EMP_NAME 
	,DEPT_CODE 
	,JOB_CODE 
	,TO_CHAR(HIRE_DATE, 'YY/MM/DD') HIRE_DATE 
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE EXTRACT(YEAR FROM HIRE_DATE) = '2000');

-- 5. 77년생 여자 사원과 동일한 부서이면서 동일한 사수를 가지고 있는 사원을 조회하시오
--    사번, 이름, 부서코드, 사수번호, 주민번호, 고용일

SELECT 
	 EMP_ID
	,EMP_NAME 
	,DEPT_CODE 
	,MANAGER_ID 
	,EMP_NO 
	,TO_CHAR(HIRE_DATE, 'YY/MM/DD') HIRE_DATE 
FROM EMPLOYEE
WHERE (DEPT_CODE, MANAGER_ID) = (SELECT DEPT_CODE, MANAGER_ID FROM EMPLOYEE 
																 WHERE SUBSTR(EMP_NO, 1, 2) = '77'
																 AND SUBSTR(EMP_NO, 8, 1) = '2');

-- 6. 부서별 입사일이 가장 빠른 사원의
--    사번, 이름, 부서명(NULL이면 '소속없음'), 직급명, 입사일을 조회하고
--    입사일이 빠른 순으로 조회하시오
--    단, 퇴사한 직원은 제외하고 조회..	

SELECT 
	 EMP_ID 
	,EMP_NAME 
	,NVL(DEPT_TITLE,'소속없음')
	,JOB_NAME
	,TO_CHAR(HIRE_DATE, 'YY/MM/DD') AS 입사일
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
WHERE HIRE_DATE IN (SELECT MIN(HIRE_DATE) FROM EMPLOYEE WHERE ENT_YN = 'N' GROUP BY DEPT_CODE)
ORDER BY HIRE_DATE;
-- 부서별로 그룹을 묶을 때 퇴사한 직원을 서브쿼리에서 제외해야함.
-- 왜? 부서별로 가장 빠른 입사자 구했을 때 'D8' 부서는 이태림임(이태림 퇴사자)
--> 문제점 : 부서별로 가장 빠른 입사자 구해놓고, 메인쿼리에서 퇴사자 제외해버리면
-- DB 부서는 퇴사자인 이태림이 가장 빠른 입사자이기 때문에
-- 전체 부서 중 DB 부서가 아예 제외되어 버림
--> 부서별 가장 빠른 입사자구할 때(서브쿼리) 퇴사한 직원을 뺀 상태에서 그룹으로 묶으면
-- DB 부서의 가장 빠른 입사자는 이테림 제외 후 전형돈이 됨.

-- 7. 직급별 나이가 가장 어린 직원의
--    사번, 이름, 직급명, 나이, 보너스 포함 연봉을 조회하고
--    나이순으로 내림차순 정렬하세요
--    단 연봉은 \124,800,000 으로 출력되게 하세요. (\ : 원 단위 기호)
SELECT 
	 EMP_ID 
	,EMP_NAME 
	,JOB_NAME
	,나이
	,'￦' || TO_CHAR(보너스포함연봉, 'FM999,999,999') 보너스포함연봉
FROM (
SELECT 
	 EMP_ID 
	,EMP_NAME 
	,JOB_NAME
	,JOB_CODE
	,TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), '19' || SUBSTR(EMP_NO,1,6) ) / 12) 나이
	,(SALARY * (NVL(BONUS,'0') + 1) * 12) 보너스포함연봉
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
)
WHERE (JOB_CODE, 나이) IN (SELECT  JOB_CODE
																	,MIN(TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), '19' || SUBSTR(EMP_NO,1,6) ) / 12)) 
														FROM EMPLOYEE
														GROUP BY JOB_CODE)
ORDER BY 나이 DESC;




--------------------------------------------------------------------------------------------------

-- 서브쿼리

SELECT MAX(EMP_NO) FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 메인쿼리
SELECT 
	 EMP_ID 
	,EMP_NAME 
	,JOB_NAME
	,FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO,1,6), 'RRMMDD' )) / 12) 나이
	,TO_CHAR(SALARY * (1 + NVL(BONUS,0)) * 12, 'L999,999,999') "보너스 포함 연봉"
FROM EMPLOYEE
NATURAL JOIN JOB
WHERE EMP_NO IN (SELECT MAX(EMP_NO) FROM EMPLOYEE GROUP BY JOB_CODE)
ORDER BY 나이 DESC;



























