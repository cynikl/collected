#!/bin/sh 

#the name of the printer will be showed in the printers list
printername="Accolade_SurePDF";

#device URI of PDF Printer by Adobe Professional 9.0
deviceURI="pstopdfjobready://PDFJobReady";

#the path to the PPD file
ppd="/private/etc/cups/ppd/SurePDF170_Accolade_SurePDF.ppd";

lpadmin -p $printername -v $deviceURI -E -P $ppd
