MODULE MainModule
    VAR num lx := 500; ! zacetek
    VAR num ly := 150;
    VAR num sx := 40; ! velikosti crk
    VAR num sy := 20;
    VAR num presledek := 5;
    VAR num tool_len := 200;
    VAR pos cp;
    VAR zonedata zd := z50;
    VAR num ltrs{10};
    VAR num vrstice_max{10};
    VAR num vrstice_min{10};
    VAR num vrstica := 1;

    PROC main()
        VAR string str;
        VAR num quit := 0;
        VAR string ch;
        VAR num ps := 1;
        VAR robtarget cur;
        VAR num cur_ltr := 4;
        VAR num itr := 1;
        VAR num cur_h := 40;
        VAR num line_max := 40;
        VAR num line_min := 40;

        cur := CRobT();
        ltrs        := [0,0,0,0,0,0,0,0,0,0];
        vrstice_max := [0,0,0,0,0,0,0,0,0,0];
        vrstice_min := [0,0,0,0,0,0,0,0,0,0];
        lx := cur.trans.x;
        ly := cur.trans.y;

        str := "1234567890";

        WHILE itr < StrLen(str) DO
            ch := StrPart(str, itr, 1);
            IF ch = "/" THEN
                incr vrstica;
                cur_h := 40;
                line_max := 40;
            ELSEIF ch = "+" THEN
                cur_h := cur_h + 10;
            ELSEIF ch = "-" THEN
                cur_h := cur_h - 10;
            endif
            IF cur_h >= line_max then
                line_max := cur_h;
                vrstice_max{vrstica} := line_max;
            endif
            IF cur_h <= line_min then
                line_min := cur_h;
                vrstice_min{vrstica} := line_min;
            endif
            incr itr;
        ENDWHILE

        vrstica := 1;

        novo;
        WHILE (quit = 0) DO
            ch := StrPart(str, ps, 1);
            IF     ch = "a" THEN A;
            ELSEIF ch = "b" THEN B;
            ELSEIF ch = "c" THEN C;
            ELSEIF ch = "C" THEN C_sum;
            ELSEIF ch = "d" THEN D;
            ELSEIF ch = "e" THEN E;
            ELSEIF ch = "f" THEN F;
            ELSEIF ch = "g" THEN G;
            ELSEIF ch = "h" THEN H;
            ELSEIF ch = "i" THEN I;
            ELSEIF ch = "j" THEN J;
            ELSEIF ch = "k" THEN K;
            ELSEIF ch = "l" THEN L;
            ELSEIF ch = "m" THEN M;
            ELSEIF ch = "n" THEN N;
            ELSEIF ch = "o" THEN O;
            ELSEIF ch = "p" THEN P;
            ELSEIF ch = "r" THEN R;
            ELSEIF ch = "s" THEN S;
            ELSEIF ch = "S" THEN S_sum;
            ELSEIF ch = "t" THEN T;
            ELSEIF ch = "u" THEN U;
            ELSEIF ch = "v" THEN V;
            ELSEIF ch = "z" THEN Z;
            ELSEIF ch = "Z" THEN Z_sum;
            ELSEIF ch = "." THEN pika;
            ELSEIF ch = "1" THEN st1;
            ELSEIF ch = "2" THEN st2;
            ELSEIF ch = "3" THEN st3;
            ELSEIF ch = "4" THEN st4;
            ELSEIF ch = "5" THEN st5;
            ELSEIF ch = "6" THEN st6;
            ELSEIF ch = "7" THEN st7;
            ELSEIF ch = "8" THEN st8;
            ELSEIF ch = "9" THEN st9;
            ELSEIF ch = "0" THEN st0;
            ELSEIF ch = "/" THEN nova_vrstica;
            ELSEIF ch = "-" THEN
                IF cur_ltr > 1 then
                    cur_ltr := cur_ltr - 1;
                    sx := sx - 10;
                    sy := sy - 5;
                endif
                decr ltrs{cur_ltr};
            ELSEIF ch = "+" THEN
                IF cur_ltr < 10 then
                    cur_ltr := cur_ltr + 1;
                    sx := sx + 10;
                    sy := sy + 5;
                endif
                decr ltrs{cur_ltr};
            ELSEIF ch = " " THEN naslednja;
            ENDIF
            incr ltrs{cur_ltr};
            IF StrLen(str) = ps THEN quit := 1; ENDIF
            incr ps;
        ENDWHILE
    ENDPROC
    PROC move()
        MoveL [cp,[0,0,-1,0],[0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]], v50, zd, tool0;
    ENDPROC
    PROC moveXY(Num nx, num ny)
        cp.x := cp.x + nx;
        cp.y := cp.y + ny;
        move;
    ENDPROC
    PROC moveXY_abs(num nx, num ny)
	cp.x := nx;
	cp.y := ny;
	move;
    ENDPROC
    PROC gor()
        cp.z := cp.z + 10;
        zd := z50;
        move;
    ENDPROC
    PROC dol()
        cp.z := cp.z - 10;
        zd := fine;
        move;
    ENDPROC
    PROC novo()
        cp.x := lx;
        cp.y := ly;
        cp.z := tool_len;
        move;
    ENDPROC
    PROC naslednja()
        VAR num offset_y := 0;
        VAR num offset_x := 0;
        VAR num i := 1;
        VAR num j := 1;

        WHILE i <= 10 DO
            offset_y := offset_y + (ltrs{i} * (i * 5)) + (ltrs{i} * presledek);
            Incr i;
        ENDWHILE

        WHILE j < vrstica DO
            offset_x := offset_x + vrstice_max{j} + presledek;
            Incr j;
        ENDWHILE

        cp.y := ly - offset_y;
        cp.x := lx - offset_x - (vrstice_max{vrstica} - sx);

        move;
    ENDPROC
    PROC nova_vrstica()
        VAR num i := 1;
        WHILE i <= 10 DO
            ltrs{i} := 0;
            Incr i;
        ENDWHILE
        ! hacky hack
        ltrs{4} := -1;
        incr vrstica;
    ENDPROC
    PROC A()
        naslednja;
        moveXY 0, -sy/2;
        dol;
        moveXY -sx, +sy/2;
        gor;
        moveXY +sx, -sy/2;
        dol;
        moveXY -sx, -sy/2;
        gor;
        moveXY +sx/2, +sy*3/4;
        dol;
        moveXY 0, -sy/2;
        gor;
    ENDPROC
    PROC B()
        naslednja;
        dol;
        moveXY 0, -sy*3/4;
        moveXY -sx/2, 0;
        moveXY 0, -sy/4;
        moveXY -sx/2, 0;
        moveXY 0, +sy;
        moveXY +sx, 0;
        gor;
        moveXY -sx/2, 0;
        dol;
        moveXY 0, -sy*3/4;
        gor;
    ENDPROC
    PROC C()
        naslednja;
        moveXY 0, -sy;
        dol;
        moveXY 0, +sy;
        moveXY -sx, 0;
        moveXY 0, -sy;
        gor;
    ENDPROC
    PROC C_sum()
        C;
        gor;
        moveXY +9/8*sx, +3/4*sy;
        sumnik;
    ENDPROC
    PROC sumnik()
        dol;
        moveXY -1/12*sx, -1/4*sy;
        moveXY +1/12*sx, -1/4*sy;
        gor;
    ENDPROC
    PROC D()
        naslednja;
        dol;
        moveXY 0, -sy*3/4;
        moveXY -sx, -sy/4;
        moveXY 0, +sy;
        moveXY +sx, 0;
        gor;
    ENDPROC
    PROC E()
        naslednja;
        moveXY 0, -sy;
        dol;
        moveXY 0, +sy;
        moveXY -sx, 0;
        moveXY 0, -sy;
        gor;
        moveXY +sx/2, +sy;
        dol;
        moveXY 0, -sy*3/4;
        gor;
    ENDPROC
    PROC F()
        naslednja;
        moveXY 0, -sy;
        dol;
        moveXY 0, +sy;
        moveXY -sx, 0;
        gor;
        moveXY +sx/2, 0;
        dol;
        moveXY 0, -sy*3/4;
        gor;
    ENDPROC
    PROC G()
        naslednja;
        moveXY 0, -sy;
        dol;
        moveXY 0, +sy;
        moveXY -sx, 0;
        moveXY 0, -sy;
        moveXY +sx/2, 0;
        moveXY 0, +sy/4;
        gor;
    ENDPROC
    PROC H()
        naslednja;
        dol;
        moveXY -sx, 0;
        gor;
        moveXY +sx, -sy;
        dol;
        moveXY -sx, 0;
        gor;
        moveXY +sx/2, +sy;
        dol;
        moveXY 0, -sy;
        gor;
    ENDPROC
    PROC I()
        naslednja;
        moveXY 0, -sy/2;
        dol;
        moveXY -sx, 0;
        gor;
    ENDPROC
    PROC J()
        naslednja;
        moveXY 0, -sy;
        dol;
        moveXY -sx, 0;
        moveXY 0, +sy;
        moveXY +sx*1/4, 0;
        gor;
    ENDPROC
    PROC K()
        naslednja;
        dol;
        moveXY -sx, 0;
        gor;
        moveXY 0, -sy;
        dol;
        moveXY +sx/2, +sy;
        moveXY +sx/2, -sy;
        gor;
    ENDPROC
    PROC L()
        naslednja;
        dol;
        moveXY -sx, 0;
        moveXY 0, -sy;
        gor;
    ENDPROC
    PROC M()
        naslednja;
        moveXY -sx, 0;
        dol;
        moveXY +sx, 0;
        moveXY -sx/2, -sy/2;
        moveXY +sx/2, -sy/2;
        moveXY -sx, 0;
        gor;
    ENDPROC
    PROC N()
        naslednja;
        moveXY -sx, 0;
        dol;
        moveXY +sx, 0;
        moveXY -sx, -sy;
        moveXY +sx, 0;
        gor;
    ENDPROC
    PROC O()
        naslednja;
        dol;
        moveXY -sx, 0;
        moveXY 0, -sy;
        moveXY +sx, 0;
        moveXY 0, +sy;
        gor;
    ENDPROC
    PROC P()
        naslednja;
        moveXY -sx, 0;
        dol;
        moveXY +sx, 0;
        moveXY 0, -sy;
        moveXY -sx/2, 0;
        moveXY 0, +sy;
        gor;
    ENDPROC
    PROC R()
        naslednja;
        moveXY -sx, 0;
        dol;
        moveXY +sx, 0;
        moveXY 0, -sy;
        moveXY -sx/2, 0;
        moveXY 0, +sy;
        moveXY -sx/2, -sx/2;
        gor;
    ENDPROC
    PROC S()
        naslednja;
        moveXY 0, -sy;
        dol;
        moveXY 0, +sy;
        moveXY -sx/2, 0;
        moveXY 0, -sy;
        moveXY -sx/2, 0;
        moveXY 0, +sy;
        gor;
    ENDPROC
    PROC S_sum()
        S;
        moveXY +9/8*sx, -1/4*sy;
        sumnik;
    ENDPROC
    PROC T()
        naslednja;
        dol;
        moveXY 0, -sy;
        gor;
        moveXY 0, +sy/2;
        dol;
        moveXY -sx, 0;
        gor;
    ENDPROC
    PROC U()
        naslednja;
        dol;
        moveXY -sx, 0;
        moveXY 0, -sy;
        moveXY +sx, 0;
        gor;
    ENDPROC
    PROC V()
        naslednja;
        dol;
        moveXY -sx, -sy/2;
        moveXY +sx, -sy/2;
        gor;
    ENDPROC
    PROC Z()
        naslednja;
        moveXY 0, -sy;
        dol;
        moveXY 0, +sy;
        moveXY -sx, -sy;
        moveXY 0, +sy;
        gor;
    ENDPROC
    PROC Z_sum()
        naslednja;
        Z;
        moveXY +9/8*sx, -1/4*sy;
        sumnik;
    ENDPROC
    PROC pika()
        naslednja;
        moveXY -sx, -sy/2;
        dol;
        gor;
    ENDPROC
    PROC st1()
        naslednja;
        moveXY -1/4*sx, 0;
        dol;
        moveXY +1/4*sx, -1/2*sy;
        moveXY -sx, 0;
        gor;
        moveXY 0, +1/2*sy;
        dol;
        moveXY 0, -sy;
        gor;
    ENDPROC
    PROC st2()
        naslednja;
        dol;
        moveXY 0, -sy;
        moveXY -1/2*sx, 0;
        moveXY 0, +sy;
        moveXY -1/2*sx, 0;
        moveXY 0, -sy;
        gor;
    ENDPROC
    PROC st3()
        naslednja;
        dol;
        moveXY 0, -sy;
        moveXY -sx, 0;
        moveXY 0, +sy;
        gor;
        moveXY +1/2*sx, 0;
        dol;
        moveXY 0, -sy;
        gor;
    ENDPROC
    PROC st4()
        naslednja;
        dol;
        moveXY -1/2*sx, 0;
        moveXY 0, -sy;
        gor;
        moveXY +1/4*sx, 1/2*sy;
        dol;
        moveXY -3/4*sx, 0;
        gor;
    ENDPROC
    PROC st5()
        naslednja;
        moveXY 0, -3/4*sy;
        dol;
        moveXY 0, +3/4*sy;
        moveXY -sx/2, 0;
        moveXY 0, -sy;
        moveXY -sx/2, 0;
        moveXY 0, +sy;
        gor;
    ENDPROC
    PROC st6()
        naslednja;
        moveXY 0, -3/4*sy;
        dol;
        moveXY 0, +3/4*sy;
        moveXY -sx, 0;
        moveXY 0, -sy;
        moveXY +sx/2, 0;
        moveXY 0, +3/4*sy;
        gor;
    ENDPROC
    PROC st7()
        naslednja;
        dol;
        moveXY 0, -sy;
        moveXY -sx, 1/4*sy;
        gor;
        moveXY +1/2*sx, 1/2*sy;
        dol;
        moveXY 0, -3/4*sy;
        gor;
    ENDPROC
    PROC st8()
        o;
        moveXY -1/2*sx, 0;
        dol;
        moveXY 0, -sy;
        gor;
    ENDPROC
    PROC st9()
        naslednja;
        dol;
        moveXY 0, -sy;
        moveXY -sx, 0;
        gor;
        moveXY +1/2*sx, 0;
        dol;
        moveXY 0, +sy;
        moveXY +1/2*sx, 0;
        gor;
    ENDPROC
    PROC st0()
        naslednja;
        o;
        moveXY 0, -sy;
        dol;
        moveXY -sx, +sy;
        gor;
    ENDPROC
ENDMODULE
