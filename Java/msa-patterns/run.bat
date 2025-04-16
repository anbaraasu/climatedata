
SET DEVELOPMENT_HOME=%CD%

start /min cmd /c "cd %DEVELOPMENT_HOME%\zipkin\ && java -jar c:\anbu\code\lead\msa-patterns\zipkin\zipkin-server\target\zipkin-server-3.4.5-SNAPSHOT-exec.jar"

echo Discovery Service: BUILDING

start /min cmd /c "cd %DEVELOPMENT_HOME%\discovery-service\ && mvn spring-boot:run"

echo Discovery Service: BUILD DONE
echo API Gateway: BUILDING

start /min cmd /c "cd %DEVELOPMENT_HOME%\gateway-service\ && mvn spring-boot:run"

echo Discovery Service: BUILD DONE
echo API Gateway: BUILD DONE
echo Config Service: BUILDING


start /min cmd /c "cd %DEVELOPMENT_HOME%\config-service\ && mvn spring-boot:run"

echo Discovery Service: BUILD DONE
echo API Gateway: BUILD DONE
echo Config Service: BUILD DONE
echo Employee Service: BUILDING

start /min cmd /c "cd %DEVELOPMENT_HOME%\employee-service\ && mvn spring-boot:run"

echo Discovery Service: BUILD DONE
echo API Gateway: BUILD DONE
echo Articles Service: BUILD DONE
echo Employee Service: BUILD DONE
echo Department Service: BUILDING

start /min cmd /c "cd %DEVELOPMENT_HOME%\department-service\ && mvn spring-boot:run"

echo Discovery Service: BUILD DONE
echo API Gateway: BUILD DONE
echo Articles Service: BUILD DONE
echo Employee Service: BUILD DONE
echo Department Service: BUILD DONE
echo ---
echo Starting Application...
REM docker-compose up --build
REM mvn spring-boot:run -Dspring-boot.run.arguments="--spring.application.name=employee-service-instance2"

REM REM sleep for 150 seconds
timeout /t 150 /nobreak

REM open edge browser with http://lp-pc226rtg.hclt.corp.hcl.in:8060/employee 
start msedge http://lp-pc226rtg.hclt.corp.hcl.in:8060/employee