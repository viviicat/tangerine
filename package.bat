mkdir distrib
mkdir distrib\tangerine
xcopy racket distrib\tangerine\racket /i
xcopy racket\etc distrib\tangerine\racket\etc /i
xcopy racket\collects distrib\tangerine\racket\collects /i /S
xcopy models distrib\tangerine\models /i
xcopy shaders distrib\tangerine\shaders /i
xcopy materials distrib\tangerine\materials /i
copy tangerine.exe distrib\tangerine\tangerine.exe
copy LICENSE.txt distrib\tangerine\LICENSE.txt
copy SDL2.dll distrib\tangerine\SDL2.dll
copy libracketcs_db9xz4.dll distrib\tangerine\libracketcs_db9xz4.dll
