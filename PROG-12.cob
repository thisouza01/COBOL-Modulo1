       IDENTIFICATION DIVISION.                             
       PROGRAM-ID.    EAD71912.                             
       AUTHOR.        THIAGO.                               
      ***************************************************   
      *    EXIBIR TOTAL DE VENDAS POR MES USANDO TABELA *   
      ***************************************************   
      *                                                     
       ENVIRONMENT DIVISION.                                
       CONFIGURATION SECTION.                               
       SPECIAL-NAMES.                                       
           DECIMAL-POINT IS COMMA.                          
       INPUT-OUTPUT SECTION.                                
       FILE-CONTROL.                                        
           SELECT ARQ-VENDAS ASSIGN TO VENDAS               
               FILE STATUS IS WK-FS-VENDAS.                 
      *                                                     
       DATA DIVISION.                                       
        FILE SECTION.                                           
       FD   ARQ-VENDAS                                         
            RECORDING MODE IS F.                               
       01  REG-VENDAS.                                         
           05 FD-NOTA                     PIC 9(06).           
           05 FD-MES                      PIC 99.              
           05 FD-VALOR                    PIC 9(6)V99.         
       WORKING-STORAGE SECTION.                                
       01  TABELA-TOTAIS.                                      
           03 TOTAL           PIC 9(08)V99 OCCURS 12 TIMES.    
       77  WK-TOT-EDIT        PIC ZZ.ZZZ.ZZ9,99 VALUE ZEROS.   
       77  WK-MES             PIC 99            VALUE ZEROS.   
       77  WK-FS-VENDAS       PIC XX            VALUE SPACES.  
       PROCEDURE DIVISION.                                     
       000-PRINCIPAL SECTION.                                  
       001-PRINCIPAL.                                          
           PERFORM 101-INICIAR.                                
             PERFORM 201-PROCESSAR UNTIL WK-FS-VENDAS = '10'.         
            PERFORM 901-FINALIZAR.                                   
            STOP RUN.                                                
      *******************************************************       
        100-INICIAR SECTION.                                         
        101-INICIAR.                                                 
            OPEN INPUT ARQ-VENDAS.                                   
            EVALUATE WK-FS-VENDAS                                    
                WHEN '00'                                            
                    PERFORM 301-LER-VENDAS                           
                WHEN '35'                                            
                    DISPLAY 'ARQUIVO VENDAS NAO ENCONTRADO'          
                    MOVE 12 TO RETURN-CODE                           
                    STOP RUN                                         
                WHEN OTHER                                           
                    DISPLAY 'ERRO: ' WK-FS-VENDAS                    
                            ' O COMANDO OPEN VENDAS'                 
                    MOVE 12 TO RETURN-CODE                       
                   STOP RUN                                     
           END-EVALUATE.                                        
      *******************************************************   
       200-PROCESSAR SECTION.                                   
       201-PROCESSAR.                                           
           ADD FD-VALOR TO TOTAL(FD-MES).                       
           PERFORM 301-LER-VENDAS.                              
      *******************************************************   
       300-LER-VENDAS SECTION.                                  
       301-LER-VENDAS.                                          
           READ ARQ-VENDAS.                                     
           EVALUATE WK-FS-VENDAS                                
               WHEN '00'                                        
                   CONTINUE                                     
               WHEN '10'                                        
                   CONTINUE                                     
                WHEN OTHER                                        
                   DISPLAY 'ERRO: ' WK-FS-VENDAS                 
                           ' O COMANDO READ VENDAS'              
                   MOVE 12 TO RETURN-CODE                        
                   STOP RUN                                      
           END-EVALUATE.                                         
      *******************************************************    
       900-FINALIZAR SECTION.                                    
       901-FINALIZAR.                                            
           PERFORM VARYING WK-MES FROM 1 BY 1 UNTIL WK-MES > 12  
               MOVE TOTAL(WK-MES) TO WK-TOT-EDIT                 
               DISPLAY 'TOTAL DE VENDAS DO MES ' WK-MES          
                       ' = ' WK-TOT-EDIT                         
           END-PERFORM.                                          
           CLOSE ARQ-VENDAS.                                                    