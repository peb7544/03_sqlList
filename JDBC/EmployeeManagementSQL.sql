SELECT 
	 EMP_ID 
	,EMP_NAME 
	,EMP_NO 
	,EMAIL
	,PHONE 
	,NVL(DEPT_TITLE,'부서없음') DEPT_TITLE
	,JOB_NAME
	,SALARY 
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
ORDER BY EMP_ID;


SELECT 
	 EMP_ID 
	,EMP_NAME 
	,EMP_NO 
	,EMAIL
	,PHONE 
	,NVL(DEPT_TITLE,'부서없음') DEPT_TITLE
	,JOB_NAME
	,SALARY 
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE EMP_ID = '200'
ORDER BY EMP_ID;

-- 입력받은 부서와 일치하는 모든 사원 정보 조회
SELECT 
	 EMP_ID 
	,EMP_NAME 
	,EMP_NO 
	,EMAIL
	,PHONE 
	,NVL(DEPT_TITLE,'부서없음') DEPT_TITLE
	,JOB_NAME
	,SALARY 
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE DEPT_TITLE = '총무부'
ORDER BY EMP_ID;

-- 입력받은 급여 이상을 받는 모든 사원 정보 조회
SELECT 
	 EMP_ID 
	,EMP_NAME 
	,EMP_NO 
	,EMAIL
	,PHONE 
	,NVL(DEPT_TITLE,'부서없음') DEPT_TITLE
	,JOB_NAME
	,SALARY 
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE SALARY >= 5000000
ORDER BY EMP_ID;

-- 부서별 급여 합 전체 조회
SELECT 
	 NVL(DEPT_CODE,'부서없음') DEPT_CODE
	,SUM(SALARY) SALARY
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- 주민번호가 일치하는 사원 정보 조회
SELECT 
	 EMP_ID 
	,EMP_NAME 
	,EMP_NO 
	,EMAIL
	,PHONE 
	,NVL(DEPT_TITLE,'부서없음') DEPT_TITLE
	,JOB_NAME
	,SALARY 
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE EMP_NO = '621231-1985634'
ORDER BY EMP_ID;

-- 직급별 급여 평균 조회
SELECT 
	 JOB_NAME
	,ROUND(AVG(SALARY),1) || '원' SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
GROUP BY JOB_NAME, JOB_CODE
ORDER BY SALARY;