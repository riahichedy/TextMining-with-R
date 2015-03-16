#!/usr/bin/env python27

#Importing the modules
from xlrd import open_workbook

wb = open_workbook('Test 1.xlsx')
feuille4=wb.sheet_by_index(0)
Skills=33 #colonne 33 
kwords=open_workbook('kw.xlsx')
fkw=kwords.sheet_by_index(0)

# Start the counting
for kw_number in range(1,152):
	cip=0
	ind=0
	sme=0
	inno=0
	sb=0
	ca=0
	net=0
	db=0
	pap=0
	op=0
	keyword=fkw.cell(kw_number,0).value
	print keyword
	for i in range(1,3138):
		sk=feuille4.cell(i,Skills).value
		delta=0	
		if (sk.find(keyword)!=-1):
			cip+=feuille4.cell(i,0).value
			ind+=feuille4.cell(i,1).value
			net+=feuille4.cell(i,2).value
			sme+=feuille4.cell(i,3).value
			inno+=feuille4.cell(i,4).value
			sb+=feuille4.cell(i,5).value
			ca+=feuille4.cell(i,6).value
			db+=feuille4.cell(i,7).value
			pap+=feuille4.cell(i,8).value
			op+=feuille4.cell(i,9).value
	text_file=open('result.txt',"a")
	save_string=keyword+" "+ str(cip)+" "+str(ind)+" "+str(net)+" "+str(sme)+" "+str(inno)+" "+str(sb)+" "+str(ca)+" "+str(db)+" "+ str(pap)+ " "+str(op)+"\n"
	text_file.write(save_string)

	
