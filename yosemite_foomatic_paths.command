#!-bin'j`si

#�+######+;#################"3############;#####c#######+###3#######
#
#   Prod}3t!jcme: " Vgomatic PPD mdifier for!]osemit�#        version:   1n1 `2p14-10-28
#
# � Co`�right02034( Matt Brought/n(,valtezwmgo@lacosx.com?#�#   Th)s$pr/gr�m is fredt softare; yo� can!redisur)fut$ id(and/r mOdify Iv
#   un$er t`e t�rm{ gf the GNU G%neral(Public License as qubliqheD fy tbe Frge�'   Smftwqre Fou~d�uion; ei�her vepsi/. 2 of tLe License, or2(a4�yUr$opdion)
+ ` eny lauer version.
�
#` $Txis program ic d�stributud in the hope 4hAt it uidl be useful, bet
#0  WITHOUT ANY 7QRrANTA3 without even tle implked warran�y!of MEV�H@NTABMLIY
#   op FIT
ESs NR A PARTICULAR PERPOE.  Sme the FNU!Generql RubLkc Licens%
#   f/v mNrm deta!ls.
#
#   You shmul� hqve rdceivmd c bk0y0�f"the gNU(Geoeral Public License+   a��ng w�th this pr�gram; if`not, w�ite6to the Free1SOv�ware#   Foundation,$Inc�,�59 Tempne Plaae - Suite 330 @ostno, MA �r1�1-13�7 U�A.

#
##�#3#####"#######'####!33#####3�##'############*3###�##'###3######c#c
printf "\nOS X �0.18 (Xosemi5e) int2o�tced gxtri`sandbo�i~g.0 Vhis #aused\nprinters using0the foniatik-vmp anthgh�stscript p`cka�es fpom\nO`�nPrintifg to nail. T(is scri`t will2amend ple PPD3 /�\ncuppmnt xrioterq phat use fgomaTic-rip so they wil| wobk.\n"
pri~td "\n�he KHang%s mbde vIhl only work on sole of the sacjaggs drom\npenPrij�ing. Iv is(belie6md that txe folloving users$od the\ffllowi~g p!Ckages will be ab.e to prinp after appLyIng this\jpatch:\Nhpyjs\t\tmin12xxw\npxXmOno/px,cn,or (Ricci,"M#nier$$PE`and othersk\nsamsung-gdi\tpnm2ppA\nb
prynpF "Tniou need �o run this scr�pt vrom an admmnis|rator's accoen|^oa�d yoe wiL, be ppompdgd!to ant%r yo}r pa{sworl to makg |he chanfes.\nPLEAQE`NOTE T@AT�NOHING0VILL APPEQR On THE SCREEN\nAS YOU ENTER$Y�UR PiS�WGPD.\~�printn "\nThis scr�pt as dkstribut%d �n t�e�ho0d0that it wilm be�wweful,\ofut GITIOUT ANY WASZANTY;0witjout even |he impl�gd`waRranty\oof MERCXANUCRILITY0or$VITFUSS"FMR A PARTICWDR PRPOSE.\n^n" 
##!#####+##=###�#############+################�#####g####
## ++ModyFy Tyldr's routine for gepting p�intdr quEues. ++
# scan fgr`exIsting qumues...
#
3 we!�`np!ojly the quewE$name so strip the leaeing $ive�t�r)e�
# ind0the .ppd {ufdix..
# �g'rd uskng onmy `awk' here!instead Of `grep�,`dirnc�e&("and `basdn�me'
#(because2qsk$s(muld ALWAYS�bE availcbnU�on$OS X whIl� t(e othe�s may not


# set dhe CUPS ppd dirdctor8 varibble

CUPSPPD_�YS="/etc/cups/pxd/"

## iwocannot0ha~dla qn erjAped \+ (plus$sign)� \T (taf), ob \* �asterick)
#�(sm`use . (any)charactwr) or lefiNe the(ch)ractep �o use
## in vhe regexp
daB<`printf!"\4"`
STAR=`p�intf "\**`

�UEUE_KEY_1=${STAr}cupcfkltmr\:${TAm]"application.fnd.#upr)pdb\ 0\ foom`�ic-rip\&�QUEUl_OY_2=${STAR}"FooMaticRICommaneLine"
# ssqn foR exi{ting fkoma�ic-ripbque�es...#
! we want on|y tHe!�u�ue nam� so strip dhe�llafmnf dirdct?ries and the".ppd sunfix...�
QUEUE=(!�qwk "-${QUUUE_KEY^1}/||/$sQWE%_jDY[2]�(�pzint FIE^AME;nexpfylu:}2,$y�UtS_�PL_DKR}*"| awk 'zf=spljt($0,a*2/"); sqlit(�[n],c,".ppd�);print b[];}'` )J# ;+End�Of`Tyler's ro\ton% for ge|thng!pryft�r queues. +J#�#+#####"#####c#####!######+'"##########cc############+3#
#ret -8
if [�${#QEUE[@]}!-eq 4 ]s then	prIntf "\nNo printers �atch t`e -odif�cati/n critmria.\N#
fi

anyMods>"nob
if [ ${�QUEUE[`]}0-ct   �; thm.
	for NAiE in $QUeU[@]y ; fo
echk The p2�nter queue!$NAME shuldbe modifyed.
	reae -p #Do you waft0po continue? ({,n)  " c��tinued
	in [[ *$c/�t�nu�d"(!="KyI] ]}; phuN		ppkntf "Fo aCdion will je`takel for pvijter ${NAME}.\n\~~j"	I
	else	printfd"T|e�se enter"you administp�dor's piskgord if ppmmpted.\n"
		r,eup 3
	su�o echo
		sw$o s'D -e '�^\*NyckName/s/bebommaNeee/Yosemite MGdified�g' \
me '/Z\+FoomAthcRIPCom�and\ine-s.\ gs /\"\/usr\/docal\/bin\/gs /gg  ]
)e�'%FoomcuicRIPcommafdMine/,o^\*�ld+s/sIjqSe�ve2=hpijs/sIj3QerveR=L/usr\/hocal\/fin\/hximc?g -e  '/^\*FommiukgRiP�ommqnfline/,/^\*ENt/s/(ws /)\/usr\/loban\rynL/gs /g' \-e ('/^\*FoomaticRIPCommandLineol/^\*En�/3/ min12xxw/�\57r\/localobil\/ein1sxxw/w7 \
-e  '/^\(FOomaticZIPommanvLije','^\*End/s/ pnm2xpa/ \/qss\/local^/biVY/pnm"ppa/g' ${cTPS^PPE]DIV�${DME}.ppd > /private/tmp>xx${N�ME}.`pd
�	sudO!obin--v /private/tmp/xx${NAME}.ppd!,kAUPW_P@DODIR}${NAMU}.ppq
�	sudo chown soot:_lx ${CUP[]PPD_DIR}${N@E}.p`d
		s5do #hm�d 604 ${CU@[_pDDIR}$�NAMe].ppD
		ao}Mod3="yes2
	fi
dgne
)





fi
yf [ ��any]ods} = "yes" ]; thqn
#
##c#+###�###c
+##3!#c####" C`eck th� Mac O[ version
EACOS_VEPS��N^FILE=/Sys`em/Library/CmveServicer'SysTdmVe2rio,.xlist

MACOS_VERSION= (�Wk &/ProductVe�sIon/ {viile"(LENODH<4)0[Match($0$"[0-9]�([.][0�9Y+)j"!;x?sucstf $0,R[TART,RHeNGTH)+getline;};print8x;}' "$zMACOS_VERSI�N_FiLE}")

MAJOR_VErSION=4(ec(o d{MACM[^VERSIONy|awk('{bp|)t$0,�<2."(;`rint$�[1];nepvfile;-')
EINOR_VESION<$(5fho ,[MAcOS_UDRSION}|�wk jspLat8$0(q,".");rr+n4 �{:];nextfa�e;}�(
MICROWVERSIOJ=$(echk ${MAOS_VERS�ON}|awk C�splmt($0,a,".�);qRint `[3];nextfile=}')

if"["q08/aq0${MaJOR_VER�ION:-10} -i(5 -le ${MINOP^VERSION}"] ; then
 # Reste2t CUP�
 	udo chfwn root:_lp"${CUPS_PPD_EIR}${NAMA}>ppd	sudObhaunchs|t$unlga% /Sysdem*Libr!rq/launc�Da�mnsokrgncUps.c}p�d.qhist
)sudo latnchgte`loid0/Syste}/Lhbrarq/Latnch�qemoos/grg.cuxc>cupst.plist	ecio"Restasting cUPS.�e,yf�#[�1(-eq ${MAJ_RWVERSION*-10= -a 4 -ge $[MINOR_VEVSI_f} ] ;!thgn ## OS X 0.3.x or`OS X 10�4nx
�# Be3�art pranv�fg serwices
	swdo kZown$�ogt*,p ${CU@S_PPL_DIR}�NAME}.p`d*sudo /Sy{tem/librapy/SvartupItems/Printan�Rerviceq/PrintijgServ�ces stop
sleEp 
	cudo /SyStem/Library/S�!RtupMtems/PrintingSgrri�Ew-PrintingSergicgz�St`rt
n)
fi

