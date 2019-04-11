+-+-+-+-+- MovAut -+-+-+-+-+
En esta primera version hemos implementado las bases del PathFinder.
Adjuntamos una demo del codigo, en la que puede crear puntos en la posicion del raton apretando p.
Puede probar como los puntos cercanos son reconocidos como un mismo objeto y la linea dibujada entre 
el centro y el raton es capaz de detectar si un objeto esta en su camino.

ERRORES CONOCIDOS:
-El programa no reconoce teclas a veces. Este es un bug del propio Processing y su unica solucion es
cerrar y volver a abrir el programa.
-El programa identifica como si estuvieran en su camino objetos que, aunque si que se cruzan con la recta,
lo hacen mas lejos de donde termina el segmento, y por tanto, no son un obstáculo real.