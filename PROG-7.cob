       IDENTIFICATION DIVISION.                          
       PROGRAM-ID.    EAD71907.                          
       AUTHOR.        THIAGO.                            
      *************************************              
      *    RESGATE DE DIVIDA            *                
      *************************************              
      *                                                  
       ENVIRONMENT DIVISION.                             
       CONFIGURATION SECTION.                            
       SPECIAL-NAMES.                                    
           DECIMAL-POINT IS COMMA.                       
      *                                                  
       DATA DIVISION.                                    
       WORKING-STORAGE SECTION.                          
       77  PRESTACAO      PIC 9(5)V99      VALUE ZEROS.  
       77  PRESTACAO-EDIT PIC ZZ.ZZ9,99    VALUE ZEROS.  
       77  TAXA           PIC 9V99         VALUE ZEROS.  
        77  DIVIDA         PIC 9(7)V99      VALUE ZEROS.  
       77  DIVIDA-EDIT    PIC Z.ZZZ.ZZ9,99 VALUE ZEROS.  
       77  JUROS          PIC 9(5)V99      VALUE ZEROS.  
       77  JUROS-EDIT     PIC ZZ.ZZ9,99    VALUE ZEROS.  
       77  MES            PIC 999          VALUE ZEROS.  
      *                                                  
       PROCEDURE DIVISION.                               
       UNICA SECTION.                                    
       INICIO.                                           
           ACCEPT DIVIDA   FROM SYSIN.                   
           ACCEPT PRESTACAO FROM SYSIN.                  
           ACCEPT TAXA     FROM SYSIN.                   
           PERFORM CALCULO UNTIL DIVIDA EQUAL ZEROS.     
           MOVE DIVIDA TO DIVIDA-EDIT.                   
           DISPLAY 'A DIVIDA FOI PAGA EM '         MES   
                   ' MESES '.                            
           STOP RUN.                                     
        CALCULO.                                              
           COMPUTE JUROS = DIVIDA * TAXA / 100.              
           IF JUROS = DIVIDA * TAXA / 100                    
               DISPLAY 'PRESTACAO MUITO BAIXA'               
               STOP RUN                                      
           END-IF.                                           
           ADD JUROS        TO DIVIDA.                       
           IF DIVIDA < PRESTACAO                             
               MOVE DIVIDA TO PRESTACAO                      
           END-IF.                                           
           SUBTRACT PRESTACAO FROM DIVIDA.                   
           ADD 1            TO MES.                          
           MOVE DIVIDA      TO DIVIDA-EDIT.                  
           MOVE PRESTACAO   TO PRESTACAO-EDIT.               
           MOVE JUROS       TO JUROS-EDIT.                   
           DISPLAY 'NO MES '                      MES        
                   ' O JURO = '                   JUROS-EDIT 
                   ' A PRESTACAO = '              PRESTACAO-EDIT 
                   ' E A DIVIDA = '               DIVIDA-EDIT.                  