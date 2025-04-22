       IDENTIFICATION DIVISION.                   
       PROGRAM-ID.    EAD71902.                   
       AUTHOR.        THIAGO.                     
      ***********************************         
      *    EXIBIR BENVINDO AO COBOL *             
      ***********************************         
      *                                           
       ENVIRONMENT DIVISION.                      
      *                                           
       DATA DIVISION.                             
       WORKING-STORAGE SECTION.                   
       01  DATA-SIST.                             
           03 ANO-SIST    PIC 99    VALUE ZEROS.  
           03 MES-SIST    PIC 99    VALUE ZEROS.  
           03 DIA-SIST    PIC 99    VALUE ZEROS.  
       01  DATA-EXIBE.                            
           03 DIA-EXIBE   PIC 99    VALUE ZEROS.  
           03 FILLER      PIC X     VALUE '/'.   
           03 MES-EXIBE   PIC 99    VALUE ZEROS. 
           03 FILLER      PIC XXX   VALUE '/20'. 
           03 ANO-EXIBE   PIC 99    VALUE ZEROS. 
       01  HORA-SIST.                            
           03 HOR-SIST    PIC 99    VALUE ZEROS. 
           03 MIN-SIST    PIC 99    VALUE ZEROS. 
           03 SEG-SIST    PIC 99    VALUE ZEROS. 
           03 CEN-SIST    PIC 99    VALUE ZEROS. 
       01  HORA-EXIBE.                           
           03 HOR-EXIBE   PIC 99    VALUE ZEROS. 
           03 FILLER      PIC X     VALUE ':'.   
           03 MIN-EXIBE   PIC 99    VALUE ZEROS. 
           03 FILLER      PIC X     VALUE ':'.   
           03 SEG-EXIBE   PIC 99    VALUE ZEROS. 
           03 FILLER      PIC X     VALUE ':'.   
           03 CEN-EXIBE   PIC 99    VALUE ZEROS.     
        77  NOME           PIC A(10) VALUE SPACES.
      *                                          
       PROCEDURE DIVISION.                       
       UNICA SECTION.                            
       INICIO.                                   
           ACCEPT NOME FROM SYSIN.               
           ACCEPT DATA-SIST FROM DATE.           
           ACCEPT HORA-SIST FROM TIME.           
                                                 
           MOVE DIA-SIST TO DIA-EXIBE.           
           MOVE MES-SIST TO MES-EXIBE.           
           MOVE ANO-SIST TO ANO-EXIBE.           
                                                 
           MOVE HOR-SIST TO HOR-EXIBE.           
           MOVE MIN-SIST TO MIN-EXIBE.           
           MOVE SEG-SIST TO SEG-EXIBE.           
           MOVE CEN-SIST TO CEN-EXIBE.           
                                              
           DISPLAY 'OLA ' NOME                  
                   ', BENVINDO AO CURSO COBOL'. 
           DISPLAY 'A DATA EH : ' DATA-EXIBE.   
           DISPLAY 'HORA : ' HORA-EXIBE.        
           STOP RUN.                                    