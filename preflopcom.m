function [OPTION]=preflopcom(cartas_computadora, mapacartas)

%%Computadora 
flopcomtotal=[cartas_computadora];
valores_computadora1=cellfun(@(cartas) mapacartas(cartas(1:end-1)), flopcomtotal);
%Verificar carta alta, pareja o trío
carta_alta1=any(valores_computadora1 > 8);
unicos1=unique(valores_computadora1);
repeticiones1=histc(valores_computadora1, unicos1);
pareja1=any(repeticiones1 == 2);
if carta_alta1 || pareja1
        OPTION=2;
        if carta_alta1
            OPTION=2;
        end
        if pareja1
            OPTION=2;
        end
else
    OPTION=3;
end