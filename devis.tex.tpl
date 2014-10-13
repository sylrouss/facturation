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

\def\ClientName{<%= CONFIG['clients'][CLIENT]['name'] %>}
\def\ClientAddress{%
	<%= CONFIG['clients'][CLIENT]['address.way'] %> \\
	<%= CONFIG['clients'][CLIENT]['address.zipcode'] %> <%= CONFIG['clients'][CLIENT]['address.town'] %>
}

\def\TJM{<%= CONFIG['clients'][CLIENT]['invoice.TJM'] %>}
\def\WorkDescription{<%= CONFIG['clients'][CLIENT]['work.description'] %>}

\def\DevisDescription{<%= CONFIG['clients'][CLIENT]['devis.description'] %>}
\def\DevisNumber{<%= CONFIG['clients'][CLIENT]['devis.number'] %>}
\def\DevisDayCount{<%= CONFIG['clients'][CLIENT]['devis.workDayCount'] %>}

\newcommand{\AddProduct}[3]{
	\FPround{\price}{#3}{2}
	\FPeval{\amount}{#2 * #3}
	\FPround{\amount}{\amount}{2}
	\FPadd{\TotalHT}{\TotalHT}{\amount}
	
	\addto\Products{#1 & \price & #2 & \amount}
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

\AddProduct{\DevisDescription\cr\WorkDescription}{\DevisDayCount}{\TJM}

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
	\textbf{Devis n°: \DevisNumber}
\end{center}

{\addtolength{\leftskip}{10.5cm}
	\textbf{\ClientName} \\
	\ClientAddress \\

}

\hspace*{10.5cm}
\CompanyTown, le \datedate

~\\

\begin{center}
	\begin{tabular}{p{7cm}ccc}
		\textbf{Désignation} & \textbf{Prix unitaire} & \textbf{Quantité} & \textbf{Montant (EUR)} \\
		\cr \hline \ComputeInvoice{}
	\end{tabular}
\end{center}

\end{document}
