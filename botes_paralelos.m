function [BOTE_PRINCIPAL,BOTE_SECUNDARIO,BOTE_TERCIARIO,botes,jug_AI]=botes_paralelos(botes,ALL_IN,fold_A,aportes_juego,aportes_ronda)

%Inicializar variables
jug_activo=0;
jug_AI=0;
aportes_juego_BP=[];
aportes_juego_BS=[];
aportes_juego_BT=[];
BOTE_PRINCIPAL=0;
BOTE_SECUNDARIO=0;
BOTE_TERCIARIO=0;

%1.Evaluar jugadores activos
if fold_A(1)==1
  jug_activo=jug_activo+1;
end
if fold_A(2)==1
    jug_activo=jug_activo+1;
end
if fold_A(3)==1
    jug_activo=jug_activo+1;
end

%2.Evaluar jugadores "ALL IN"
if ALL_IN(1)==1
    jug_AI=jug_AI+1;
end
if ALL_IN(2)==1
    jug_AI=jug_AI+1;
end
if ALL_IN(3)==1
    jug_AI=jug_AI+1;
end

%3.Ordenar de menor a mayor el vector "aportes_ronda"
aportes_juego_BP=sort(aportes_juego);

%4.Verificar numero de botes
if aportes_ronda(1)==aportes_ronda(2) && aportes_ronda(2)==aportes_ronda(3)
elseif aportes_ronda(1)==aportes_ronda(2) || aportes_ronda(2)==aportes_ronda(3) || aportes_ronda(1)==aportes_ronda(3)
    botes=2;
elseif aportes_ronda(1)~=aportes_ronda(2) && aportes_ronda(2)~=aportes_ronda(3) && aportes_ronda(1)~=aportes_ronda(3)
    botes=3;
end

%5. BOTE PRINCIPAL
BOTE_PRINCIPAL=aportes_juego_BP(1)*jug_activo;
%5.1 Restar "aporte menor" a los demas aportes
aportes_juego_BS(1)=aportes_juego_BP(2)-aportes_juego_BP(1);
aportes_juego_BS(2)=aportes_juego_BP(3)-aportes_juego_BP(1);

%6. BOTE SECUNDARIO
BOTE_SECUNDARIO=aportes_juego_BS(1)*(jug_activo-1);
%6.1 Restar "aporte menor" a los demas aportes
aportes_juego_BT=aportes_juego_BS(2)-aportes_juego_BS(1);

%7. BOTE TERCIARIO
BOTE_TERCIARIO=aportes_juego_BT(1)*(jug_activo-2);