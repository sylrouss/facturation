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

\def\TVA{20}
\def\TotalHT{0}
\def\TotalTVA{0}

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

\def\ClientBdC{<%= CONFIG['clients'][CLIENT]['bdc'] %>}
\def\ClientName{<%= CONFIG['clients'][CLIENT]['name'] %>}
\def\ClientAddress{%
	<%= CONFIG['clients'][CLIENT]['address.way'] %> \\
	<%= CONFIG['clients'][CLIENT]['address.zipcode'] %> <%= CONFIG['clients'][CLIENT]['address.town'] %>
}

\def\TJM{<%= CONFIG['clients'][CLIENT]['invoice.TJM'] %>}
\def\WorkDayCount{<%= CONFIG['clients'][CLIENT]['invoice.workDayCount'] %>}
\def\WorkDescription{<%= CONFIG['clients'][CLIENT]['work.description'] %>}

\def\InvoiceNumber{<%= CONFIG['clients'][CLIENT]['invoice.number'] %>}
\def\InvoicePaid{no}

\def\HasAvoir{<%= CONFIG['clients'][CLIENT]['avoir'] %>}
\def\AvoirNumber{<%= CONFIG['clients'][CLIENT]['avoir.number'] %>}
\def\AvoirWorkDayCount{<%= CONFIG['clients'][CLIENT]['avoir.workDayCount'] %>}

\newcommand{\AddProduct}[3]{
	\FPround{\price}{#3}{2}
	\FPeval{\amount}{#2 * #3}
	\FPround{\amount}{\amount}{2}
	\FPadd{\TotalHT}{\TotalHT}{\amount}
	
	\addto\Products{#1 & \price & #2 & \amount}
}

\newcommand{\AddAvoir}[3]{
	\FPround{\price}{#3}{2}
	\FPeval{\amount}{#2 * #3}
	\FPround{\amount}{\amount}{2}
	\FPsub{\TotalHT}{\TotalHT}{\amount}
	
	\addto\Products{\cr #1 & \price & #2 & \amount \cr}
}

\newcommand{\ComputeInvoice}{%
	\cr \Products \cr

	\FPeval{\TotalTVA}{\TotalHT * \TVA / 100}
	\FPadd{\TotalTTC}{\TotalHT}{\TotalTVA}
	\FPround{\TotalHT}{\TotalHT}{2}
	\FPround{\TotalTVA}{\TotalTVA}{2}
	\FPround{\TotalTTC}{\TotalTTC}{2}
	\global\let\TotalHT\TotalHT
	\global\let\TotalTVA\TotalTVA
	\global\let\TotalTTC\TotalTTC
	
	\cr \hline \cr
	Total HT& & & \TotalHT \cr
	TVA \TVA~\% & & & \TotalTVA \cr \cr
	\hline \hline \cr
	\textbf{Total TTC} & & & \TotalTTC
}

\newcommand{\Products}{}

\AddProduct{\WorkDescription}{\WorkDayCount}{\TJM}
\ifthenelse{\equal{\HasAvoir}{yes}}{
\AddAvoir{Avoir n°: \AvoirNumber}{\AvoirWorkDayCount}{\TJM}
}{}


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
		 \multirow{5}{*}{ \includegraphics[natwidth=100,natheight=60]{logo.png} } & \\
			& \textbf{\CompanyName} \\
			& \CompanyWayName \\
		   	& {\CompanyZipCode} {\CompanyTown} \\
			& \\
		\hline
		\hline
	\end{tabular}
\end{center}

\begin{center}
	\textbf{Facture n°: \InvoiceNumber}
\end{center}

{\addtolength{\leftskip}{10.5cm}
	\textbf{\ClientName} \\
	\ClientAddress \\

}

\hspace*{10.5cm}
\CompanyTown, le \datedate

~\\

\begin{center}
	\textbf{Bon de Commande : \ClientBdC}
\end{center}

~\\

\newcolumntype{P}[1]{>{\raggedright}p{#1}}
\begin{center}
	\begin{tabular}{P{7cm}ccc}
		\textbf{Désignation} & \textbf{Prix unitaire} & \textbf{Quantité} & \textbf{Montant (EUR)} \\
		\cr \hline \ComputeInvoice{}
	\end{tabular}
\end{center}

~\\

\ifthenelse{\equal{\InvoicePaid}{yes}}{
\begin{center}
	\textbf{Facture acquittée.}
\end{center}
}{
	\addtocounter{datenumber}{30}%
	\setdatebynumber{\thedatenumber}%

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

}

\end{document}
