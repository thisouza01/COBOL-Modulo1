        IDENTIFICATION DIVISION.                                 
        PROGRAM-ID.    EAD71915.                                 
        AUTHOR.        THIAGO.                                   
      ********************************************************  
      *  MONSTAR MES E DIA DA SEMANA POR EXTENSO             *  
      ********************************************************  
      *                                                         
        ENVIRONMENT DIVISION.                                    
        CONFIGURATION SECTION.                                   
        SPECIAL-NAMES.                                           
            DECIMAL-POINT IS COMMA.                              
        INPUT-OUTPUT SECTION.                                    
        FILE-CONTROL.                                            
      *                                                         
        DATA DIVISION.                                           
        WORKING-STORAGE SECTION.                                 
        01  NOMES-MES.                                           
            03 FILLER                    PIC X(9)    VALUE 'JANEIRO'.    
           03 FILLER                    PIC X(9)    VALUE 'FEVEREIRO'.  
           03 FILLER                    PIC X(9)    VALUE 'MARCO'.      
           03 FILLER                    PIC X(9)    VALUE 'ABRIL'.      
           03 FILLER                    PIC X(9)    VALUE 'MAIO'.       
           03 FILLER                    PIC X(9)    VALUE 'JUNHO'.      
           03 FILLER                    PIC X(9)    VALUE 'JULHO'.      
           03 FILLER                    PIC X(9)    VALUE 'AGOSTO'.     
           03 FILLER                    PIC X(9)    VALUE 'SETEMBRO'.   
           03 FILLER                    PIC X(9)    VALUE 'OUTUBRO'.    
           03 FILLER                    PIC X(9)    VALUE 'NOVEMBRO'.   
           03 FILLER                    PIC X(9)    VALUE 'DEZEMBRO'.   
       01  TABELA-MESES       REDEFINES NOMES-MES.                      
           03 NOME-MES                  PIC X(09)  OCCURS 12 TIMES.     
       01 NOMES-SEM.                                                    
           03 FILLER                   PIC X(13)  VALUE 'SEGUNDA-FEIRA'.
           03 FILLER                   PIC X(13)  VALUE 'TERCA-FEIRA'.  
            03 FILLER                   PIC X(13)  VALUE 'QUARTA-FEIRA'.
           03 FILLER                   PIC X(13)  VALUE 'QUINTA-FEIRA'.
           03 FILLER                   PIC X(13)  VALUE 'SEXTA-FEIRA'. 
           03 FILLER                   PIC X(13)   VALUE 'SABADO'.     
           03 FILLER                   PIC X(13)   VALUE 'DOMINGO'.    
       01  TABELA-SEMANA     REDEFINES NOMES-SEM.                      
           03 NOME-SEM                 PIC X(13)  OCCURS 7 TIMES.      
       LINKAGE SECTION.                                                
       01  LK-AREA-COM.                                                
           05 LK-COD-MES-COM            PIC 99.                        
           05 LK-COD-DIASEM-COM         PIC 9.                         
           05 LK-NOME-MES-COM           PIC X(9).                      
           05 LK-NOME-DIASEM-COM        PIC X(13).                     
      *                                                                
       PROCEDURE DIVISION USING LK-AREA-COM.                           
       000-PRINCIPAL SECTION.                                          
       001-PRINCIPAL.                                                  
             PERFORM 101-INICIAR.                                       
            PERFORM 201-PROCESSAR.                                     
            PERFORM 901-FINALIZAR.                                     
            GOBACK.                                                    
      *******************************************************         
        100-INICIAR SECTION.                                           
        101-INICIAR.                                                   
            EXIT.                                                      
      *******************************************************         
        200-PROCESSAR SECTION.                                         
        201-PROCESSAR.                                                 
            MOVE NOME-MES(LK-COD-MES-COM)     TO   LK-NOME-MES-COM.    
            MOVE NOME-SEM(LK-COD-DIASEM-COM)  TO   LK-NOME-DIASEM-COM. 
      *******************************************************         
        900-FINALIZAR SECTION.                                         
        901-FINALIZAR.                                                 
               EXIT.                