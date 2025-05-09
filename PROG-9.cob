       IDENTIFICATION DIVISION.                      
       PROGRAM-ID.    EAD71909.                      
       AUTHOR.        THIAGO.                        
      *************************************          
      *    BALANCE LINE                   *          
      *************************************          
      *                                              
       ENVIRONMENT DIVISION.                         
       CONFIGURATION SECTION.                        
       SPECIAL-NAMES.                                
           DECIMAL-POINT IS COMMA.                   
       INPUT-OUTPUT SECTION.                         
       FILE-CONTROL.                                 
           SELECT ARQ-CLIENTES ASSIGN TO CLIENTES    
               FILE STATUS IS WK-FS-CLIENTES.        
           SELECT ARQ-LANCAM   ASSIGN TO LANCAM      
               FILE STATUS IS WK-FS-LANCAM.          
             SELECT ARQ-CLIENTEN ASSIGN TO CLIENTEN      
                FILE STATUS IS WK-FS-CLIENTEN.          
      *                                                
        DATA DIVISION.                                  
        FILE SECTION.                                   
        FD   ARQ-CLIENTES                               
             RECORDING MODE IS F.                       
        01  REG-CLIENTES.                               
            05 FD-CHAVE-CLIENTES.                       
                10 FD-AGENCIA-CLIENTES     PIC X(4).    
                10 FD-CONTA-CLIENTES       PIC 9(5).    
            05 FD-NOME-CLIENTES            PIC A(20).   
            05 FD-SALDO-CLIENTES           PIC 9(6)V99. 
        FD   ARQ-LANCAM                                 
             RECORDING MODE IS F.                       
        01  REG-LANCAM.                                 
            05 FD-CHAVE-LANCAM.                         
                10 FD-AGENCIA-LANCAM       PIC X(4).                    
               10 FD-CONTA-LANCAM         PIC 9(5).                    
           05 FD-DOC-LANCAM               PIC 9(4).                    
           05 FD-TIPO-LANCAM              PIC A.                       
           05 FD-VALOR-LANCAM             PIC 9(6)V99.                 
       FD   ARQ-CLIENTEN                                               
            RECORDING MODE IS F.                                       
       01  REG-CLIENTEN.                                               
           05 FD-CHAVE-CLIENTEN.                                       
               10 FD-AGENCIA-CLIENTEN     PIC X(4).                    
               10 FD-CONTA-CLIENTEN       PIC 9(5).                    
           05 FD-NOME-CLIENTEN            PIC A(20).                   
           05 FD-SALDO-CLIENTEN           PIC 9(6)V99.                 
       WORKING-STORAGE SECTION.                                        
       77  WK-FS-CLIENTES                 PIC XX         VALUE SPACES. 
       77  WK-FS-LANCAM                   PIC XX         VALUE SPACES. 
       77  WK-FS-CLIENTEN                 PIC XX         VALUE SPACES. 
       77  WK-SALDO-EDIT                  PIC ZZZ.ZZ9,99 VALUE ZEROS.  
       77  WK-VALOR-EDIT                  PIC ZZZ.ZZ9,99 VALUE ZEROS.  
      *                                                                
       PROCEDURE DIVISION.                                             
       000-PRINCIPAL SECTION.                                          
       001-PRINCIPAL.                                                  
           PERFORM 101-INICIAR.                                        
           PERFORM 201-PROCESSAR UNTIL WK-FS-CLIENTES = '10'           
                                 AND   WK-FS-LANCAM   = '10'.          
           PERFORM 901-FINALIZAR.                                      
           STOP RUN.                                                   
      *******************************************************          
       100-INICIAR SECTION.                                            
       101-INICIAR.                                                    
           PERFORM 102-ABRIR-CLIENTES.                                 
           PERFORM 103-ABRIR-LANCAM.                                   
           PERFORM 104-ABRIR-CLIENTEN.                                 
        102-ABRIR-CLIENTES.                                    
           OPEN INPUT ARQ-CLIENTES.                           
           EVALUATE WK-FS-CLIENTES                            
               WHEN '00'                                      
                   PERFORM 301-LER-CLIENTES                   
               WHEN '35'                                      
                   DISPLAY 'ARQUIVO CLIENTES NAO ENCONTRADO'  
                   MOVE 12 TO RETURN-CODE                     
                   STOP RUN                                   
               WHEN OTHER                                     
                   DISPLAY 'ERRO: ' WK-FS-CLIENTES            
                           ' O COMANDO OPEN CLIENTES'         
                   MOVE 12 TO RETURN-CODE                     
                   STOP RUN                                   
           END-EVALUATE.                                      
       103-ABRIR-LANCAM.                                      
           OPEN INPUT ARQ-LANCAM.                             
            EVALUATE WK-FS-LANCAM                            
               WHEN '00'                                    
                   PERFORM 302-LER-LANCAM                   
               WHEN '35'                                    
                   DISPLAY 'ARQUIVO LANCAM NAO ENCONTRADO'  
                   MOVE 12 TO RETURN-CODE                   
                   STOP RUN                                 
               WHEN OTHER                                   
                   DISPLAY 'ERRO: ' WK-FS-LANCAM            
                           ' O COMANDO OPEN CLIENTES'       
                   MOVE 12 TO RETURN-CODE                   
                   STOP RUN                                 
           END-EVALUATE.                                    
       104-ABRIR-CLIENTEN.                                  
           OPEN OUTPUT ARQ-CLIENTEN.                        
           EVALUATE WK-FS-CLIENTEN                          
               WHEN '00'                                    
                     CONTINUE                                         
                WHEN OTHER                                           
                    DISPLAY 'ERRO: ' WK-FS-CLIENTEN                  
                            ' O COMANDO OPEN CLIENTEN'               
                    MOVE 12 TO RETURN-CODE                           
                    STOP RUN                                         
            END-EVALUATE.                                            
      ******************************************************       
        200-PROCESSAR SECTION.                                       
        201-PROCESSAR.                                               
            EVALUATE TRUE                                            
                WHEN FD-CHAVE-CLIENTES LESS THAN FD-CHAVE-LANCAM     
                    PERFORM 202-GRAVAR-CLIENTEN                      
                    PERFORM 301-LER-CLIENTES                            
               WHEN FD-CHAVE-CLIENTES EQUAL FD-CHAVE-LANCAM            
                   PERFORM 203-EXEC-LANCAM                             
                   PERFORM 302-LER-LANCAM                              
               WHEN OTHER                                              
                   DISPLAY 'CHAVE DE LANCAMENTO: ' FD-CHAVE-LANCAM     
                           ' ESTA ERRADA NO DOCUMENTO ' FD-DOC-LANCAM  
                   PERFORM 302-LER-LANCAM                              
           END-EVALUATE.                                               
       202-GRAVAR-CLIENTEN.                                            
           MOVE FD-SALDO-CLIENTES TO WK-SALDO-EDIT.                    
           DISPLAY '    SALDO FINAL = ' WK-SALDO-EDIT.                 
           MOVE REG-CLIENTES TO REG-CLIENTEN.                          
           WRITE REG-CLIENTEN.                                         
           IF WK-FS-CLIENTEN NOT EQUAL '00'                            
               DISPLAY 'ERRO: ' WK-FS-CLIENTEN                         
                       ' O COMANDO WRITE CLIENTEN'                     
                MOVE 12 TO RETURN-CODE                                  
               STOP RUN                                                
           END-IF.                                                     
       203-EXEC-LANCAM.                                                
           EVALUATE FD-TIPO-LANCAM                                     
               WHEN 'C'                                                
                   ADD FD-VALOR-LANCAM   TO FD-SALDO-CLIENTES          
                   MOVE FD-VALOR-LANCAM  TO WK-VALOR-EDIT              
                   DISPLAY '        CREDITO: ' WK-VALOR-EDIT           
               WHEN 'D'                                                
                   IF FD-VALOR-LANCAM GREATER THAN FD-SALDO-CLIENTES   
                       DISPLAY 'SALDO INSUFICIENTE NO DOCUMENTO '      
                               FD-DOC-LANCAM                           
                   ELSE                                                
                       SUBTRACT FD-VALOR-LANCAM FROM FD-SALDO-CLIENTES 
                       MOVE FD-VALOR-LANCAM  TO WK-VALOR-EDIT          
                   DISPLAY '        DEBITO: ' WK-VALOR-EDIT            
                    END-IF                                          
               WHEN OTHER                                          
                   DISPLAY 'TIPO LANCAMENTO: ' FD-TIPO-LANCAM      
                           ' ESTA ERRADO NO DOC ' FD-DOC-LANCAM    
           END-EVALUATE.                                           
      *******************************************************      
       300-LER-CLIENTES SECTION.                                   
       301-LER-CLIENTES.                                           
           READ ARQ-CLIENTES.                                      
           EVALUATE WK-FS-CLIENTES                                 
               WHEN '00'                                           
                   MOVE FD-SALDO-CLIENTES TO WK-SALDO-EDIT         
                   DISPLAY FD-AGENCIA-CLIENTES ' '                 
                           FD-CONTA-CLIENTES ' '                   
                           FD-NOME-CLIENTES ' '                    
                   DISPLAY '    SALDO INICIAL = ' WK-SALDO-EDIT    
               WHEN '10'                                           
                    MOVE HIGH-VALUES TO FD-CHAVE-CLIENTES      
               WHEN OTHER                                     
                   DISPLAY 'ERRO: ' WK-FS-CLIENTES            
                           ' O COMANDO READ CLIENTES'         
                   MOVE 12 TO RETURN-CODE                     
                   STOP RUN                                   
           END-EVALUATE.                                      
       302-LER-LANCAM.                                        
           READ ARQ-LANCAM.                                   
           EVALUATE WK-FS-LANCAM                              
               WHEN '00'                                      
                   CONTINUE                                   
               WHEN '10'                                      
                   MOVE HIGH-VALUES TO FD-CHAVE-LANCAM        
               WHEN OTHER                                     
                   DISPLAY 'ERRO: ' WK-FS-LANCAM              
                           ' O COMANDO READ LANCAM'           
                     MOVE 12 TO RETURN-CODE                       
                    STOP RUN                                     
            END-EVALUATE.                                        
      *******************************************************   
        900-FINALIZAR SECTION.                                   
        901-FINALIZAR.                                           
            CLOSE ARQ-CLIENTES.                                  
            CLOSE ARQ-LANCAM.                                    
            CLOSE ARQ-CLIENTEN.                                  
            IF WK-FS-CLIENTEN NOT EQUAL '00'                     
                DISPLAY 'ERRO ' WK-FS-CLIENTEN                   
                        ' NO COMANDO CLOSE CLIENTEN'             
                DISPLAY 'ERRO AO SALVAR ARQUIVO'                 
                MOVE 12 TO RETURN-CODE                           
            END-IF. 