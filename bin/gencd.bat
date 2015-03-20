@echo off

setlocal & pushd

if {%CD_VIEW%}=={} (
	set _VIEW_OPT=
	set _DOT_FILE=graph.dot
	set _GIF_FILE=design.gif
) else (
	set _VIEW_OPT= -view %CD_VIEW%
	set _DOT_FILE=graph.dot
	set _GIF_FILE=%CD_VIEW%.gif
)

find . -name "*.java" | xargs cmd /c javadoc -docletpath %~dp0.\UmlGraph.jar -doclet org.umlgraph.doclet.UmlGraph %1 %2 %3 %4 %5 %6 %7 %8 %9 %_VIEW_OPT%

dot -Gratio=0.7 -Eminlen=2 -Tgif -o%_GIF_FILE% %_DOT_FILE%
start %_GIF_FILE%

:_END
endlocal & popd
