\documentclass[french,11pt]{article}
\usepackage{babel}
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage[a4paper]{geometry}
\usepackage{units}
\usepackage{bera}
\usepackage{graphicx}
\usepackage{fancyhdr}
\usepackage{fp}
\usepackage{datenumber}
\usepackage{multirow}
\usepackage{array}

\def\TotalHT{0}

\def\CompanyName{<%= CONFIG['company']['card.name'] %>}
\def\CompanyCapital{<%= CONFIG['company']['card.capital'] %>}
\def\CompanyNAFCode{<%= CONFIG['company']['card.NAFCode'] %>}
\def\CompanySIREN{<%= CONFIG['company']['card.SIREN'] %>}
\def\CompanyRCS{<%= CONFIG['company']['card.RCS'] %>}
\def\CompanyTVAKey{<%= CONFIG['company']['card.TVAKey'] %>}

\def\CompanyWayName{<%= CONFIG['company']['address.way'] %>}
\def\CompanyZipCode{<%= CONFIG['company']['address.zipcode'] %>}
\def\CompanyTown{<%= CONFIG['company']['address.town'] %>}

\def\CompanyPhone{<%= CONFIG['company']['contact.phone'] %>}
\def\CompanyWeb{<%= CONFIG['company']['contact.web'] %>}
\def\CompanyContact{<%= CONFIG['company']['contact.mail'] %>}

\def\BankCode{<%= CONFIG['company']['bank.code'] %>}
\def\BankCounter{<%= CONFIG['company']['bank.counter'] %>}
\def\BankAccountId{<%= CONFIG['company']['bank.accountId'] %>}
\def\BankAccountRIBKey{<%= CONFIG['company']['bank.accountRIBKey'] %>}
\def\BankIBANNumber{<%= CONFIG['company']['bank.accountIBANNumber'] %>}
\def\BankBICCode{<%= CONFIG['company']['bank.accountBICCode'] %>}

\def\ClientName{<%= CONFIG['clients'][CLIENT]['name'] %>}
\def\ClientAddress{%
	<%= CONFIG['clients'][CLIENT]['address.way'] %> \\
	<%= CONFIG['clients'][CLIENT]['address.zipcode'] %> <%= CONFIG['clients'][CLIENT]['address.town'] %>
}

\def\TJM{<%= CONFIG['clients'][CLIENT]['invoice.TJM'] %>}
\def\WorkDayCount{<%= CONFIG['clients'][CLIENT]['invoice.workDayCount'] %>}
\def\WorkDescription{<%= CONFIG['clients'][CLIENT]['work.description'] %>}

\def\ExpenseNumber{<%= CONFIG['clients'][CLIENT]['expense.number'] %>}

\newcommand{\AddProduct}[2]{
	\FPround{\price}{#2}{2}
	\FPadd{\TotalHT}{\TotalHT}{\price}
	
	\addto\Products{#1 & #2\cr}
}

\newcommand{\ComputeExpense}{%
	\cr	\Products \cr

	\FPround{\TotalHT}{\TotalHT}{2}
	\global\let\TotalHT\TotalHT

	\cr \hline \hline \cr
	\textbf{Total Note de Frais} & \TotalHT
}

\newcommand{\Products}{}

\AddProduct{Péage 23 Juin 2013}{15.10}
\AddProduct{Brasserie Des Lys 23 Juin 2013}{10.90}
\AddProduct{Elior du 24 au 28 Juin 2013}{41.91}
\AddProduct{La Poterne 24 Juin 2013}{30.00}
\AddProduct{L'Escargot Entêté 25 Juin 2013}{27.00}
\AddProduct{Paul 26 Juin 2013}{7.15}
\AddProduct{Bistrot Basque 26 Juin 2013}{26.70}
\AddProduct{Bistrot Basque 27 Juin 2013}{29.70}
\AddProduct{Péage 28 Juin 2013}{15.10}
\AddProduct{Indemnités kilométriques pour véhicule 6 CV fiscaux du 23 au 28 Juin 2013 : 545km à 0.561€/km}{305.75}

\geometry{verbose,tmargin=4em,bmargin=8em,lmargin=6em,rmargin=6em}
\setlength{\parindent}{0pt}
\setlength{\parskip}{1ex plus 0.5ex minus 0.2ex}

\thispagestyle{fancy}
\pagestyle{fancy}
\setlength{\parindent}{0pt}

\renewcommand{\headrulewidth}{0pt}
\cfoot{
	{\CompanyName}  au capital de {\CompanyCapital} € ~--~ {\CompanyWayName} - {\CompanyZipCode} {\CompanyTown}\newline
	\small{
		Téléphone : \CompanyPhone ~--~ Site web : \CompanyWeb ~--~ E-mail : \CompanyContact\newline
		{\CompanySIREN} {\CompanyRCS} ~--~ Code APE \CompanyNAFCode ~--~ Numéro TVA : FR{\CompanyTVAKey} {\CompanySIREN}
	}
}

\begin{document}

\setdatetoday

\begin{center}
	\begin{tabular}{cl}
		\hline
		\hline
		 \multirow{5}{*}{ \includegraphics{logo.png} } & \\
			& \textbf{\CompanyName} \\
			& \CompanyWayName \\
		   	& {\CompanyZipCode} {\CompanyTown} \\
			& \\
		\hline
		\hline
	\end{tabular}
\end{center}

\begin{center}
	\textbf{Note de frais n°: \ExpenseNumber}
\end{center}

{\addtolength{\leftskip}{10.5cm}
	\textbf{\ClientName} \\
	\ClientAddress \\

}

\hspace*{10.5cm}
\CompanyTown, le \datedate

~\\

	\begin{tabular}{p{12.5cm}r}
		\textbf{Désignation} & \textbf{Montant (EUR)} \\
		\cr \hline \ComputeExpense{}
	\end{tabular}

~\\

À régler par chèque ou par virement bancaire % avant le \datedate :
\begin{center}
	\begin{tabular}{|c c c c|}
		\hline \textbf{Code banque} & \textbf{Code guichet} & \textbf{N° de Compte} & \textbf{Clé RIB}	\\
			\BankCode & \BankCounter & \BankAccountId & \BankAccountRIBKey \\
		\hline \textbf{IBAN N°} & \multicolumn{3}{|l|}{ \BankIBANNumber } \\
		\hline \textbf{Code BIC} & \multicolumn{3}{|l|}{ \BankBICCode } \\
		\hline
	\end{tabular}
\end{center}

\end{document}
