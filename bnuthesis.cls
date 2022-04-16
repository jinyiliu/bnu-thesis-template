% Copyright (C) 2010-2012 by Gerry
%
% This file may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3a
% of this license or (at your option) any later version.
% The latest version of this license is in:
%
% http://www.latex-project.org/lppl.txt
%
% Modified by Jinyi Liu 2019/4/11



% 基本信息
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{bnuthesis}
[2014/3/12 1.52 Beijing Normal University Thesis Template]



% 定义文档所使用编码
\newif\ifbnu@UTF
\newif\ifbnu@GBK
\DeclareOption{utf}{\bnu@UTFtrue\bnu@GBKfalse}
\DeclareOption{gbk}{\bnu@GBKtrue\bnu@UTFfalse}


% 定义论文类型是否涉密
\hyphenation{bnu-Thesis}
\def\bnuthesis{\textsc{BNUThesis}}
\def\version{1.51}
\newif\ifbnu@bachelor\bnu@bachelorfalse
\newif\ifbnu@master\bnu@masterfalse
\newif\ifbnu@doctor\bnu@doctorfalse
\newif\ifbnu@secret\bnu@secretfalse
\newif\ifbnu@twoside\bnu@twosidefalse
\DeclareOption{bachelor}{\bnu@bachelortrue}
\DeclareOption{master}{\bnu@mastertrue}
\DeclareOption{doctor}{\bnu@doctortrue}
\DeclareOption{secret}{\bnu@secrettrue}
\DeclareOption{twoside}{\bnu@twosidetrue}


% 使用 dvips, dvipdfm, pdflatex 还是 xelatex
\newif\ifbnu@dvips
\newif\ifbnu@dvipdfm
\newif\ifbnu@xetex
\newif\ifbnu@pdftex
\DeclareOption{dvips}{\bnu@dvipstrue}
\DeclareOption{dvipdfm}{\bnu@dvipdfmtrue}
\DeclareOption{pdftex}{\bnu@pdftextrue}
\DeclareOption{xetex}{\bnu@xetextrue}


% 如果需要使用 arial 字体，请打开 [arial] 选项
\newif\ifbnu@arial
\DeclareOption{arial}{\bnu@arialtrue}			% 目录中是否使用 arial 字体
\newif\ifbnu@arialtoc
\DeclareOption{arialtoc}{\bnu@arialtoctrue}		% 章节标题中是否使用 arial 字体
\newif\ifbnu@arialtitle
\DeclareOption{arialtitle}{\bnu@arialtitletrue}


% 将选项传递给 book 类
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ExecuteOptions{utf,arialtitle}
\ProcessOptions\relax
\LoadClass[12pt, a4paper, openany]{book}


% 指定论文类型为学士、硕士、博士论文
\ifbnu@bachelor\relax\else
  \ifbnu@master\relax\else
    \ifbnu@doctor\relax\else
      \ClassError{bnuthesis}%
                 {You have to specify one of thesis options: bachelor, master or doctor.}{}
    \fi
  \fi
\fi

% 检查用户指定的选项和实际编译命令是否冲突
\RequirePackage{ifpdf, ifxetex}
\ifbnu@xetex\RequireXeTeX\fi
\def\RequirePDFTeX{
	\ifpdf\else
    	\ClassError{bnuthesis}
			{pdflatex is required to compile this document!}{}
	\fi}
\ifbnu@pdftex\RequirePDFTeX\fi
\def\bnu@checkoption#1#2{
	\@for\reserved@a:=#2\do{
		\csname ifbnu@\reserved@a\endcsname
			\ClassError{bnuthesis}
				{Please remove `\reserved@a' option when you run #1.}{}
    	\fi}}
\ifpdf\bnu@checkoption{pdflatex}{dvips,dvipdfm,xetex}\bnu@pdftextrue\fi
\ifxetex\bnu@checkoption{xelatex}{dvips,dvipdfm,pdftex}\bnu@xetextrue\fi




% 装载宏包
\RequirePackage{ifthen, calc}							% 引用宏包和相应的定义
\RequirePackage{amsmath, amssymb, amsfonts}				% AMS-TEX 宏包，用来排出更漂亮的公式
\RequirePackage{txfonts}								% 用很爽的 txfonts 替换 mathptmx 宏包
\RequirePackage{graphicx}								% 图形支持宏包
\RequirePackage{titletoc}
\RequirePackage[config]{subfig}							% 并排图形
\RequirePackage{indentfirst}							% 首行缩进
\RequirePackage[neverdecrease]{paralist}				% 更好的列表环境



% 中文支持宏包
\ifbnu@xetex
	\RequirePackage{xltxtra, xunicode}
	\RequirePackage[BoldFont]{xeCJK}
	\RequirePackage{CJKnumb}
	% 全角标点符号
	\punctstyle{quanjiao}
	\def\CJK@null{\kern\CJKnullspace\hskip \f@size \p@\kern\CJKnullspace}
	\defaultfontfeatures{Mapping=tex-text}
	
	% 自动调用 fonts 文件夹里的字体
	\setCJKmainfont[Path=fonts/, AutoFakeBold = {2.5}, ItalicFont = simkai.ttf]{simsun.ttc}  % 主要字体
	\setCJKsansfont[Path=fonts/, AutoFakeBold = {3}]{simhei.ttf}        % 无衬线字体
	\setCJKmonofont[Path=fonts/]{simkai.ttf}             % 等宽字体
	\setCJKfamilyfont{song}[Path=fonts/, AutoFakeBold = {2.5}]{simsun.ttc}
	\setCJKfamilyfont{hei}[Path=fonts/, AutoFakeBold = {3}]{simhei.ttf}
	\setCJKfamilyfont{kai}[Path=fonts/]{simkai.ttf}
	\setCJKfamilyfont{fs}[Path=fonts/]{simfang.ttf}
	\setCJKfamilyfont{li}[Path=fonts/]{simli.ttf}
	\setCJKfamilyfont{you}[Path=fonts/]{simyou.ttf}
	
	
	\setmainfont{Times New Roman}
	\setsansfont{Arial}
	\setmonofont{Courier New}
	
\else
	\RequirePackage{CJKutf8}
	\RequirePackage{CJKnumb}
	\ifbnu@GBK
    \IfFileExists{CJKpunct.sty}{\RequirePackage{CJKpunct}}
                 {\ClassWarning{bnuthesis}{no CJKpunct.sty availiable!}}\fi
	\RequirePackage{CJKspace}

	\ifbnu@arial
    	\IfFileExists{arial.sty}
                 	{\RequirePackage{arial}}
                 	{\ClassWarning{bnuthesis}{no arial.sty availiable!}}\fi
\fi



% 重定义字体命令
\newcommand{\song}{\CJKfamily{song}}			% 宋体
\def\songti{\song}
\newcommand{\fs}{\CJKfamily{fs}}				% 仿宋
\def\fangsong{\fs}
\newcommand{\kai}{\CJKfamily{kai}}				% 楷体
\def\kaishu{\kai}
\newcommand{\hei}{\CJKfamily{hei}}				% 黑体
\def\heiti{\hei}
\newcommand{\li}{\CJKfamily{li}}				% 隶书
\def\lishu{\li}
\newcommand{\you}{\CJKfamily{you}}				% 幼圆
\def\youyuan{\you}



% 定义类环境宏包
\RequirePackage[amsmath, thmmarks, hyperref]{ntheorem}				% amsmath 用来兼容 ams-tex 宏包
\RequirePackage{array, longtable}									% 表格控制
\RequirePackage{booktabs}											% 三线表
\RequirePackage[numbers,super,sort&compress]{natbib}				% 参考文献引用宏包


% 生成有书签的 pdf 及其开关，请结合 gbk2uni 避免书签乱码
\RequirePackage{hyperref}
\ifxetex
	\hypersetup{
		CJKbookmarks=true}
\else
	\hypersetup{
		unicode=true,
		CJKbookmarks=false}\fi
\hypersetup{
	bookmarksnumbered=true,
	bookmarksopen=true,
	bookmarksopenlevel=1,
	breaklinks=true,
	colorlinks=false,
	plainpages=false,
	pdfborder=0 0 0}


\ifbnu@dvips\RequirePackage{breakurl}\fi		% dvips 格式下网址断字有问题，加入这个包解决
\urlstyle{same}									% 设置 URL 样式
\RequirePackage{hypernat}						% hypernat 让 hyperref 和 natbib 协调的工作




% 双面开关
\newcommand{\clpage}{\ifbnu@twoside\cleardoublepage\else\clearpage\fi}

\renewcommand\frontmatter{
 	\clpage
	\@mainmatterfalse
	\pagenumbering{Roman}
	\pagestyle{bnu@empty}}
\renewcommand\mainmatter{
	\clpage
	\@mainmattertrue
	\pagenumbering{arabic}
	\pagestyle{bnu@plain}}
\renewcommand\backmatter{
	\clpage
	\@mainmattertrue}



% 避免字号选择和行距的紧耦合
% 所有字号定义时为单倍行距，并提供制定行距的倍数
\newlength\bnu@linespace
\newcommand{\bnu@choosefont}[2]{%
   \setlength{\bnu@linespace}{#2*\real{#1}}\fontsize{#2}{\bnu@linespace}\selectfont}
\def\bnu@define@fontsize#1#2{
  \expandafter\newcommand\csname #1\endcsname[1][\baselinestretch]{\bnu@choosefont{##1}{#2}}}



% 定义字号
\bnu@define@fontsize{yuanchu}{48bp}
\bnu@define@fontsize{chuhao}{42bp}
\bnu@define@fontsize{xiaochu}{36bp}
\bnu@define@fontsize{yihao}{26bp}
\bnu@define@fontsize{xiaoyi}{24bp}
\bnu@define@fontsize{erhao}{22bp}
\bnu@define@fontsize{xiaoer}{18bp}
\bnu@define@fontsize{sanhao}{16bp}
\bnu@define@fontsize{xiaosan}{15bp}
\bnu@define@fontsize{sihao}{14bp}
\bnu@define@fontsize{banxiaosi}{13bp}
\bnu@define@fontsize{xiaosi}{12bp}
\bnu@define@fontsize{dawu}{11bp}
\bnu@define@fontsize{wuhao}{10.5bp}
\bnu@define@fontsize{xiaowu}{9bp}
\bnu@define@fontsize{liuhao}{7.5bp}
\bnu@define@fontsize{xiaoliu}{6.5bp}
\bnu@define@fontsize{qihao}{5.5bp}
\bnu@define@fontsize{bahao}{5bp}



% 正文小四号字，行距为固定值 20pt
\renewcommand\normalsize{%
	\@setfontsize\normalsize{12bp}{20bp}
	\abovedisplayskip=10bp \@plus 2bp \@minus 2bp
	\abovedisplayshortskip=10bp \@plus 2bp \@minus 2bp
	\belowdisplayskip=\abovedisplayskip
	\belowdisplayshortskip=\abovedisplayshortskip}



% 页面设置
\AtBeginDvi{\special{papersize=\the\paperwidth,\the\paperheight}}
\AtBeginDvi{\special{!%
      \@percentchar\@percentchar BeginPaperSize: a4
      ^^Ja4^^J\@percentchar\@percentchar EndPaperSize}}



% 页边距设置
% 每一页面的上边距和左边距侧（订口）分别留边 25mm
% 下边距和右边距（切口）应分别留边 20mm
\RequirePackage{geometry}
\geometry{left=2.5cm, right=2cm, top=2.5cm, bottom=3.25cm, foot=1.5cm}
\setlength{\hoffset}{-1in} 							% 清空默认页边距	
\ifbnu@twoside
	\setlength{\oddsidemargin}{2.5cm}				% 奇数页左边距
	\setlength{\evensidemargin}{2cm}				% 偶数页左边距
\else
	\setlength{\oddsidemargin}{2.5cm}				% 奇数页左边距
	\setlength{\evensidemargin}{\oddsidemargin}		% 偶数页左边距
\fi




% 页眉页脚
% 新的一章最好从奇数页开始
\let\bnu@cleardoublepage\cleardoublepage
\newcommand{\bnu@clearemptydoublepage}{%
	\clearpage{\pagestyle{empty}\bnu@cleardoublepage}}
\let\cleardoublepage\bnu@clearemptydoublepage



% 定义页眉页脚
\def\ps@bnu@empty{%
	\let\@oddhead\@empty%
	\let\@evenhead\@empty%
	\let\@oddfoot\@empty%
	\let\@evenfoot\@empty}
\def\ps@bnu@plain{%
	\let\@oddhead\@empty%
	\let\@evenhead\@empty%
	\def\@oddfoot{\hfil\wuhao\thepage\hfil}%
	\let\@evenfoot=\@oddfoot}
\def\ps@bnu@headings{%
	\def\@oddhead{\vbox to\headheight{%
		\hb@xt@\textwidth{\hfill\wuhao\song\leftmark\hfill}%
		\vskip2pt\hbox{\vrule width\textwidth height0.4pt depth0pt}}}
	\def\@evenhead{\vbox to\headheight{%
		\hb@xt@\textwidth{\wuhao\song%
		\hfill\leftmark\hfill}%
		\vskip2pt\hbox{\vrule width\textwidth height0.4pt depth0pt}}}
	\def\@oddfoot{\hfil\wuhao\thepage\hfil}
	\let\@evenfoot=\@oddfoot}
% 其实可以直接写到 \chapter 的定义里面
\renewcommand{\chaptermark}[1]{\@mkboth{\@chapapp\  ~~#1}{}}




% 段落
% 用于中文段落缩进和正文板式
\newlength\CJK@twochars
\ifxetex
	\def\CJK@spaceChar{\hskip \f@size \p@}
\else
	\ifbnu@UTF
		\def\CJK@spaceChar{\CJKchar{"080}{"080}}\fi
	\ifbnu@GBK
		\def\CJK@spaceChar{\CJKchar{"0A1}{"0A1}}\fi
\fi
\def\CJKindent{%
	\settowidth\CJK@twochars{\CJK@spaceChar\CJK@spaceChar}%
	\parindent\CJK@twochars}




% 段落之间的垂直距离
\setlength{\parskip}{0pt \@plus2pt \@minus0pt}
% 调整默认列表环境间的距离，以符合中文习惯
\def\bnu@item@space{%
	\let\itemize\compactitem
	\let\enditemize\endcompactitem
	\let\enumerate\compactenum
	\let\endenumerate\endcompactenum
	\let\description\compactdesc
	\let\enddescription\endcompactdesc}

  

% 脚注
\RequirePackage[perpage]{footmisc}



% 脚注字体：宋体小五，单倍行距，悬挂缩进 1.5 字符
\def\bnu@textcircled#1{%
	\ifnum \value{#1} <10 \textcircled{\xiaoliu\arabic{#1}}
	\else\ifnum \value{#1} <100 \textcircled{\qihao\arabic{#1}}\fi\fi}
\renewcommand{\thefootnote}{\bnu@textcircled{footnote}}
\renewcommand{\thempfootnote}{\bnu@textcircled{mpfootnote}}
\def\footnoterule{\vskip-3\p@\hrule\@width0.3\textwidth\@height0.4\p@\vskip2.6\p@}
\let\bnu@footnotesize\footnotesize
\renewcommand\footnotesize{\bnu@footnotesize\xiaowu[1.5]}
\def\@makefnmark{\textsuperscript{\hbox{\normalfont\@thefnmark}}}
\long\def\@makefntext#1{
	\bgroup
		\setbox\@tempboxa\hbox{%
			\hb@xt@ 2em{\@thefnmark\hss}}
		\leftmargin\wd\@tempboxa
		\rightmargin\z@
		\linewidth \columnwidth
		\advance \linewidth -\leftmargin
		\parshape \@ne \leftmargin \linewidth
		\footnotesize
		\@setpar{{\@@par}}%
		\leavevmode
		\llap{\box\@tempboxa}%
		#1
	\par\egroup}




% 数学相关
% 允许太长的共识段行、分页等
\allowdisplaybreaks[4]
\renewcommand\theequation{\ifnum \c@chapter>\z@ \thechapter-\fi\@arabic\c@equation}


% 公式前后文的距离由 4 个参数控制，参见 \normalsize 的定义
% 公式形式是 "式（1-1）"
\def\make@df@tag{\@ifstar\bnu@make@df@tag@@\make@df@tag@@@}
\def\bnu@make@df@tag@@#1{\gdef\df@tag{\bnu@maketag{#1}\def\@currentlabel{#1}}}
\renewcommand{\eqref}[1]{\textup{(\ref{#1})}}
\renewcommand\theequation{\ifnum \c@chapter>\z@ \thechapter-\fi\@arabic\c@equation}
% 针对学士论文的设置
\def\bnu@maketag#1{\maketag@@@{(\ignorespaces #1\unskip\@@italiccorr)}}
\def\tagform@#1{\maketag@@@{(\ignorespaces #1\unskip\@@italiccorr)\equcaption{#1}}}



% 解决证明环境中方块乱跑的问题
\gdef\@endtrivlist#1{%
\if@inlabel \indent\fi
	\if@newlist \@noitemerr\fi
	\ifhmode
	\ifdim\lastskip >\z@ #1\unskip \par
		\else #1\unskip \par \fi
	\fi
\if@noparlist \else
	\ifdim\lastskip >\z@
			\@tempskipa\lastskip \vskip -\lastskip
		\advance\@tempskipa\parskip \advance\@tempskipa -\@outerparskip
		\vskip\@tempskipa
	\fi
	\@endparenv
\fi #1}



% 定理字样使用黑体，正文使用宋体，冒号隔开
\theorembodyfont{\song}
\theoremheaderfont{\hei}


% 浮动对像和表格
% 设置浮动对像和文字之间的距离
\setlength{\floatsep}{12bp \@plus4pt \@minus1pt}
\setlength{\intextsep}{12bp \@plus4pt \@minus2pt}
\setlength{\textfloatsep}{12bp \@plus4pt \@minus2pt}
\setlength{\@fptop}{0bp \@plus1.0fil}
\setlength{\@fpsep}{12bp \@plus2.0fil}
\setlength{\@fpbot}{0bp \@plus1.0fil}

% 下面这组命令使浮动对像的缺省值稍微宽松一点
\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.65}
\renewcommand{\floatpagefraction}{0.60}


% 定制浮动图形和表格标题样式
\let\old@tabular\@tabular
\def\bnu@tabular{\dawu[1.5]\old@tabular}
\DeclareCaptionLabelFormat{bnu}{{\dawu[1.5]\song #1~\rmfamily #2}}
\DeclareCaptionLabelSeparator{bnu}{\hspace{1em}}
\DeclareCaptionFont{bnu}{\dawu[1.5]}
\captionsetup{labelformat=bnu,labelsep=bnu,font=bnu}
\captionsetup[table]{position=top,belowskip={12bp-\intextsep},aboveskip=6bp}
\captionsetup[figure]{position=bottom,belowskip={12bp-\intextsep},aboveskip=6bp}
\captionsetup[subfloat]{labelformat=simple,font=bnu,captionskip=6bp,nearskip=6bp,farskip=0bp,topadjust=0bp}
\renewcommand{\thesubfigure}{(\alph{subfigure})}
\renewcommand{\thesubtable}{(\alph{subtable})}


% 采用 longtable 来处理跨页表格
\let\bnu@LT@array\LT@array
\def\LT@array{\dawu[1.5]\bnu@LT@array}


% 简单的表格使用三线表推荐用 \hlinewd
\def\hlinewd#1{%
	\noalign{\ifnum0=`}\fi\hrule \@height #1 \futurelet
		\reserved@a\@xhline}


% 章节标题，如果章节题目中的英文要使用 arial，那么就加上 \sffamily
\ifbnu@arialtitle
	\def\bnu@title@font{\sffamily}
\fi



\renewcommand\chapter{\clpage\phantomsection%
						\thispagestyle{bnu@plain}%
						\global\@topnum\z@%
						\@afterindenttrue%
						\secdef\@chapter\@schapter}
\def\@chapter[#1]#2{%
	\ifnum \c@secnumdepth >\m@ne
		\if@mainmatter
			\refstepcounter{chapter}%
			\addcontentsline{toc}{chapter}{\@chapapp \hspace{1em} #1}
		\else
			\addcontentsline{toc}{chapter}{#1}%
		\fi
	\else
		\addcontentsline{toc}{chapter}{#1}%
	\fi
\chaptermark{#1}%
\@makechapterhead{#2}}



% 正文标题：均加粗，段前后均 0.5 行
% 一级标题：三号黑体，加粗
% 二级标题：小三号黑体
% 三级标题：四号黑体
\def\@makechapterhead#1{
	\vspace*{0.5\baselineskip}%
	{\parindent \z@ \centering
		\bf \hei \csname bnu@title@font\endcsname\sanhao[1.6]
		\ifnum \c@secnumdepth >\m@ne
			\@chapapp\hskip1em
		\fi
		#1\par\nobreak
		\vskip0.5\baselineskip}}

\def\@schapter#1{%
	\@makeschapterhead{#1}
	\@afterheading}
\def\@makeschapterhead#1{%
	\vspace*{0.5\baselineskip}%
	{\parindent \z@ \centering
		\bf \hei \csname bnu@title@font\endcsname\sanhao[1.6]
			\def\@tempa{#1}
			\def\@tempb{\eabstractname}
			\ifx\@tempa\@tempb\bfseries\fi
		\interlinepenalty\@M
		#1\par\nobreak
		\vskip0.5\baselineskip}}



\newcounter{bnu@bookmark}
\def\bnu@chapter*{%
	\@ifnextchar [ % ]
		{\bnu@@chapter}
		{\bnu@@chapter@}}
\def\bnu@@chapter@#1{\bnu@@chapter[#1]{#1}}
\def\bnu@@chapter[#1]#2{%
	\@ifnextchar [ % ]
		{\bnu@@@chapter[#1]{#2}}
		{\bnu@@@chapter[#1]{#2}[]}}
\def\bnu@@@chapter[#1]#2[#3]{%
	\clpage
	\phantomsection
	\def\@tmpa{#1}
	\def\@tmpb{#3}
	\ifx\@tmpa\@empty
		\addtocounter{bnu@bookmark}\@ne
		\pdfbookmark[0]{#2}{bnuchapter.\thebnu@bookmark}
	\else
		\addcontentsline{toc}{chapter}{#1}
	\fi
	\chapter*{#2}
	\ifx\@tmpb\@empty
		\@mkboth{#2}{#2}
	\else
		\@mkboth{#3}{#3}
	\fi}



\RequirePackage{titlesec}
\titlespacing{\chapter}{0pt}{0.5\baselineskip}{0.5\baselineskip}
\renewcommand\section{\@startsection {section}{1}{\z@}%
                     { -24bp\@plus -1ex \@minus -.2ex}%
                     {6bp \@plus .2ex}%
                     {\bf \hei \csname bnu@title@font\endcsname\xiaosan[1.429]}}

\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                        {-16bp\@plus -1ex \@minus -.2ex}%
                        {6bp \@plus .2ex}%
                        {\bf \hei \csname bnu@title@font\endcsname\sihao[1.538]}}

\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                           {-16bp\@plus -1ex \@minus -.2ex}%
                           {6bp \@plus .2ex}%
                           {\bf \hei \csname bnu@title@font\endcsname\xiaosi[1.667]}}




% 目录格式
% 最多涉及 4 层，即 x.x.x.x
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}


% 每章标题行前空 6pt，后空 0pt
\renewcommand\tableofcontents{%
	\bnu@chapter*[]{\contentsname}
	\sanhao[1.5]\@starttoc{toc}\normalsize}
\ifbnu@arialtoc
	\def\bnu@toc@font{\sffamily}\fi
\def\@tocrmarg{2em}
\def\@dotsep{1}
\def\@dottedtocline#1#2#3#4#5{%
	\ifnum #1>\c@tocdepth \else
	\vskip \z@ \@plus.2\p@
		{\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
			\parindent #2\relax\@afterindenttrue
			\interlinepenalty\@M\leavevmode\@tempdima #3\relax
			\advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
			{\hei \csname bnu@toc@font \endcsname #4}\nobreak
			\leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{$\cdot$}\mkern \@dotsep mu$}\hfill
			\nobreak{\normalsize \normalcolor #5}%
			\par}%
	\fi}

% 目录格式
\titlecontents{chapter}[0em]
{\vspace{.05\baselineskip}\hei}
{\sanhao[0.0]{\thecontentslabel}~\hspace{.5em}} {}
{\dotfill\contentspage[{\makebox[0pt][r]{\thecontentspage}}]}
[\vspace{.05\baselineskip}]
\titlecontents{section}[1em]
{\vspace{.05\baselineskip}\hei}
{\xiaosan[0.0]{\thecontentslabel}~\hspace{.5em}} {}
{\dotfill\contentspage[{\makebox[0pt][r]{\thecontentspage}}]}
[\vspace{.05\baselineskip}]
\titlecontents{subsection}[2em]
{\vspace{.05\baselineskip}\hei}
{\sihao[0.0]{\thecontentslabel}~\hspace{.5em}} {}
{\dotfill\contentspage[{\makebox[0pt][r]{\thecontentspage}}]}
[\vspace{.05\baselineskip}]
\titlecontents{subsubsection}[3em]
{\vspace{.05\baselineskip}\hei}
{\xiaosi[0.0]{\thecontentslabel}~\hspace{.5em}} {}
{\dotfill\contentspage[{\makebox[0pt][r]{\thecontentspage}}]}
[\vspace{.05\baselineskip}]




% 封面和封底
% 方便定义封面的一些替换命令
\def\bnu@define@term#1{
	\expandafter\gdef\csname #1\endcsname##1{%
	\expandafter\gdef\csname bnu@#1\endcsname{##1}}
	\csname #1\endcsname{}}



% 封面、摘要、版权、致谢格式定义
\bnu@define@term{secretlevel}
\bnu@define@term{secretyear}
\bnu@define@term{ctitle}
\bnu@define@term{cdegree}
\newcommand\cdepartment[2][]{\def\bnu@cdepartment@short{#1}\def\bnu@cdepartment{#2}}
\def\caffil{\cdepartment}
\def\bnu@cdepartment@short{}
\def\bnu@cdepartment{}
\bnu@define@term{cmajor}
\def\csubject{\cmajor}

% 学士学位论文封面
\bnu@define@term{cbuyuanxi}
\bnu@define@term{czhuanye}
\bnu@define@term{cxuehao}
\bnu@define@term{cxueshengxingming}
\bnu@define@term{czhidaojiaoshi}
\bnu@define@term{czhidaojiaoshizhicheng}
\bnu@define@term{czhidaojiaoshidanwei}
\bnu@define@term{fudaojiaoshi}

% 博士（硕士）学位论文封面标题格式
\bnu@define@term{czuozhe}
\bnu@define@term{cdaoshi}
\bnu@define@term{cxibienianji}
\bnu@define@term{cxuehao}
\bnu@define@term{cxuekezhuanye}
\bnu@define@term{cwanchengriqi}
\bnu@define@term{fuzhidaojiaoshi}
\bnu@define@term{lianhezhidaojiaoshi}


\bnu@define@term{cnum}
\bnu@define@term{cdate}
\bnu@define@term{etitle}
\bnu@define@term{edegree}
\bnu@define@term{edepartment}
\def\eaffil{\edepartment}
\bnu@define@term{emajor}
\def\esubject{\emajor}
\bnu@define@term{edate}



% 摘要最好以环境的形式出现
\long\@xp\def\@xp\collect@@body\@xp#\@xp1\@xp\end\@xp#\@xp2\@xp{%
	\collect@@body{#1}\end{#2}}
\long\@xp\def\@xp\push@begins\@xp#\@xp1\@xp\begin\@xp#\@xp2\@xp{%
	\push@begins{#1}\begin{#2}}
\long\@xp\def\@xp\addto@envbody\@xp#\@xp1\@xp{%
	\addto@envbody{#1}}


% 使用 \collect@body 构建摘要环境
\newcommand{\bnu@@cabstract}[1]{\long\gdef\bnu@cabstract{#1}}
\newenvironment{cabstract}{\collect@body\bnu@@cabstract}{}
\newcommand{\bnu@@eabstract}[1]{\long\gdef\bnu@eabstract{#1}}
\newenvironment{eabstract}{\collect@body\bnu@@eabstract}{}
\def\bnu@parse@keywords#1{
	\expandafter\gdef\csname bnu@#1\endcsname{}
	\expandafter\gdef\csname #1\endcsname##1{
		\@for\reserved@a:=##1\do{
			\expandafter\ifx\csname bnu@#1\endcsname\@empty\else
				\expandafter\g@addto@macro\csname bnu@#1\endcsname{\ignorespaces\csname bnu@#1@separator\endcsname}
			\fi
			\expandafter\expandafter\expandafter\g@addto@macro%
				\expandafter\csname bnu@#1\expandafter\endcsname\expandafter{\reserved@a}}}}
\bnu@parse@keywords{ckeywords}
\bnu@parse@keywords{ekeywords}



% 封面第一页
\newlength{\bnu@title@width}
\def\bnu@put@title#1{\makebox{\hb@xt@ \bnu@title@width{#1}}}
\newcommand{\bnu@first@titlepage}{
	\begin{center}
		\vspace*{-1.8cm}
		\parbox[b][2.4cm][t]{\textwidth}{\ifbnu@secret\hfill{\sihao\bnu@secret@title}\else\rule{1cm}{0cm}\fi}
		\vskip0.3cm
		% 毛爷爷的北京师范大学
		\includegraphics[width=7.5cm]{\bnu@textlogo}
		
		\parbox[t][7cm][t]{\paperwidth-6.5cm}{
			\renewcommand{\baselinestretch}{1.5}
			\begin{center}
				\vskip-0.4cm
				% 本科毕业论文（设计）｜硕士学位论文｜博士学位论文
				\ifbnu@bachelor
        			{\xiaochu[1.2] \ziju{0.15cm} \bf \song \bnu@bachelor@subtitle}\fi
      			\ifbnu@master
        			{\chuhao[1.2] \ziju{8bp} \heiti \bnu@master@subtitle}\fi
      			\ifbnu@doctor
        			{\chuhao[1.2] \ziju{8bp} \heiti \bnu@doctor@subtitle}\fi
				
				\par\vskip1.9cm
			\end{center}
			\begin{center}
			% 论文题目
			\ifbnu@bachelor
				\begin{flushleft}
					\hskip0.3cm \sanhao[1] \bf \heiti \bnu@bachelor@thesistitle@pre
				\end{flushleft}
				\vskip0.4cm \sanhao[1] \bf \song \underline{\bnu@ctitle}
			\else
				\sanhao[1] \song \bf \bnu@thesistitle
			\fi

			\end{center}
		}
		
		% 学士论文封面包括：部院系、专业、学号、学生姓名、指导教师、指导教师职称、指导教师单位
		\ifbnu@bachelor
		\parbox[t][9.0cm][t]{\paperwidth-9cm}{
		\sanhao[1] \ \\ \ \\ \\ \vskip0.2cm
			
		\sihao[1.6] \song \bf
		\bnu@buyuanxi\bnu@title@sep\hspace{1em}\bnu@cbuyuanxi\vskip0.33cm
		\bnu@zhuanye\bnu@title@sep\hspace{1em}\bnu@czhuanye\vskip0.33cm
		\bnu@bachelor@xuehao\bnu@title@sep\hspace{1em}\bnu@cxuehao\vskip0.33cm
		\bnu@xueshengxingming\bnu@title@sep\hspace{1em}\bnu@cxueshengxingming\vskip0.33cm
		\bnu@zhidaojiaoshi\bnu@title@sep\hspace{1em}\bnu@czhidaojiaoshi\vskip0.33cm
		\bnu@zhidaojiaoshizhicheng\bnu@title@sep\hspace{1em}\bnu@czhidaojiaoshizhicheng\vskip0.33cm
		\bnu@zhidaojiaoshidanwei\bnu@title@sep\hspace{1em}\bnu@czhidaojiaoshidanwei\vskip0.33cm}
		\else
		% 博士（硕士）论文包括：作者、导师、系别年级、学号、学科专业、完成日期
		\parbox[t][9.0cm][t]{\paperwidth-12cm}{
		\sihao[1.6]
		\fs\bnu@zuozhe\bnu@title@sep\hspace{1em}\song{\bf\bnu@czuozhe}\vskip0.33cm
		\fs\bnu@daoshi\bnu@title@sep\hspace{1em}\song{\bf\bnu@cdaoshi}\vskip0.33cm
		\fs\bnu@xibienianji\bnu@title@sep\hspace{1em}\song{\bf\bnu@cxibienianji}\vskip0.33cm
		\fs\bnu@xuehao\bnu@title@sep\hspace{1em}\song{\bf\bnu@cxuehao}\vskip0.33cm
		\fs\bnu@xuekezhuanye\bnu@title@sep\hspace{1em}\song{\bf\bnu@cxuekezhuanye}\vskip0.33cm
		\fs\bnu@wanchengriqi\bnu@title@sep\hspace{1em}\song{\bf\bnu@cwanchengriqi}\vskip0.33cm
		}
		\fi
		
		\begin{center}
			\ifbnu@bachelor{\vskip3.0cm\xiaosi \song\ziju{4bp} \bf \bnu@org}\else
			{\sanhao\fs\bnu@xueweiban}\fi
		\end{center}
	\end{center}}



% 原创性声明，授权使用书
\newcommand\bnu@justspace[2][6em]{\hskip1pt {\hb@xt@ #1{\hss#2\hss}}\hskip3pt}
\newcommand\bnu@underline[2][6em]{\hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt}
\newcommand{\bnu@authorization@mk}{\vspace*{-0.1cm}
	\begin{center}
		\ifbnu@bachelor
			% 学士学位论文诚信承诺书
			{\xiaosi\song\bf\bnu@declaretitle}
		\else\vskip1cm
			% 博士（硕士）论文原创性声明
			{\sanhao\song\bf\bnu@declaretitle}
		\fi
	\end{center}
	\vskip10pt \xiaosi[1.8]  \bnu@declaration
	\vskip14pt  \bnu@declsign
	
	\begin{center}
		\ifbnu@bachelor\vskip2.5cm
			\xiaosi\song\bf\bnu@authtitle
		\else\vskip4cm
			\sanhao\song\bf\bnu@authtitle
		\fi
	\end{center}
	\vskip10pt\xiaosi[1.8]\bnu@authorization
	\ifbnu@bachelor\vskip1cm\xiaosi[1.8]\bnu@authorizationplus\fi
	
	\ifbnu@bachelor\vskip1.2cm
		\begingroup
			\parindent0pt\xiaosi
			\hspace*{2em}\bnu@authorsig\bnu@justspace[9.5em]\relax\hfill
				\bnu@org\bnu@justspace[5.5em]\relax\hspace*{3cm}\\[18pt]
				\hspace*{2em}\bnu@teachersig\bnu@justspace[9.5em]\relax\hfill
				\bnu@org\bnu@justspace[5.5em]\relax\hspace*{3cm}
		\endgroup
	\else\vskip1.2cm
    	\begingroup
      		\parindent0pt\xiaosi
      		\hspace*{2em}\bnu@authorsig\bnu@underline[9.5em]\relax\hfill%
                \bnu@frontdate\bnu@underline[9.5em]\relax\hspace*{3cm}\\[18pt]
      			\hspace*{2em}\bnu@teachersig\bnu@underline[9.5em]\relax\hfill%
              	\bnu@frontdate\bnu@underline[9.5em]\relax\hspace*{3cm}
    	\endgroup
	\fi
}

% 制作封面第一页以及原创性声明、授权使用书等内容
\newcommand{\makecover}{
	\phantomsection
	\pdfbookmark[-1]{\bnu@ctitle}{ctitle}
	\normalsize
	\begin{titlepage}
		\bnu@first@titlepage
		\clpage\bnu@authorization@mk
	\end{titlepage}
	\normalsize
	\bnu@makeabstract
	\let\@tabular\bnu@tabular}


% 摘要格式
\newcommand{\bnu@makeabstract}{%
	\cleardoublepage

	% 中文摘要：四号宋体，行距 20pt
	\bnu@chapter*[\cabstractname]{}
	\pagestyle{bnu@plain}
	\pagenumbering{Roman}
	\begin{center}
		\sanhao[1.6] \bf \hei \bnu@ctitle \par
		\vskip20bp
		\xiaosan[1.6] \bf \hei \cabstractname
	\end{center}
	\vskip20bp
	\sihao[1.6] \song \par \bnu@cabstract					% 摘要内容
	\vskip20bp
	\setbox0=\hbox{{\sihao \hei\bnu@ckeywords@title}}		% 关键词：四号黑体
	\noindent\hangindent\wd0\hangafter1
	\box0 \sihao \song \bnu@ckeywords						% 关键词内容：四号宋体
	
	% 英文摘要：小三号
	\bnu@chapter*[\eabstractname]{}
	\begin{center}
	\sanhao[1.6]\bf \bnu@etitle \par
	\vskip20bp  	
	\xiaosan[1.6]\bf \eabstractname
	\end{center}
	\vskip20bp 
	\sihao[1.6] \par \bnu@eabstract							% 摘要内容：四号，Times New Roman 字体，单倍行距
	\vskip20bp
	\setbox0=\hbox{\textbf \bnu@ekeywords@title}
	\noindent\hangindent\wd0\hangafter1
	\box0\bnu@ekeywords
	}



% 主要符号对照表
\newenvironment{denotation}[1][2.5cm]{
	\bnu@chapter*[]{\bnu@denotation@name}
	\noindent
	\begin{list}{}%
		{\vskip-30bp\xiaosi[1.6]
			\renewcommand\makelabel[1]{##1\hfil}
			\setlength{\labelwidth}{#1}	
			\setlength{\labelsep}{0.5cm}	
			\setlength{\itemindent}{0cm}	
			\setlength{\leftmargin}{\labelwidth+\labelsep}
			\setlength{\rightmargin}{0cm}
			\setlength{\parsep}{0cm}	
			\setlength{\itemsep}{0cm}
			\setlength{\listparindent}{0cm}
			\setlength{\topsep}{0pt}	
		}}{\end{list}}



% 致谢
\newenvironment{ack}{%
	\bnu@chapter*[\bnu@acklongname]{\bnu@ackname}[\bnu@acklongname]}{%
	\vskip12bp\sihao[1.5]\hei\rightline{\bnu@cxueshengxingming \hspace{1.5em}} \par \rightline{\bnu@cdate}}



% 索引部分
\def\bnu@starttoc#1{%
	\let\oldnumberline\numberline
	\def\numberline##1{\oldnumberline{\csname #1name\endcsname\hskip.4em ##1}}
	\@starttoc{\csname ext@#1\endcsname}
	\let\numberline\oldnumberline}
\def\bnu@listof#1{%
	\@ifstar
		{\bnu@chapter*[]{\csname list#1name\endcsname}\bnu@starttoc{#1}}
		{\bnu@chapter*{\csname list#1name\endcsname}\bnu@starttoc{#1}}}
\renewcommand\listoffigures{\bnu@listof{figure}}
\renewcommand*\l@figure{\@dottedtocline{1}{0em}{4em}}
\renewcommand\listoftables{\bnu@listof{table}}
\let\l@table\l@figure



% 本命令只是为了生成公式列表，所以这个 caption 是假的
% 如果编号做好使用 equation 环境，如果是其它编号环境，请手动添加 \equcaption
\def\ext@equation{loe}
\def\equcaption#1{%
	\addcontentsline{\ext@equation}{equation}
					{\protect\numberline{#1}}}


% LaTeX 没有默认的公式索引，此处定义自己的 \listofequations
\newcommand\listofequations{\bnu@listof{equation}}
\let\l@equation\l@figure



% 参考文献
% 正文引用格式，依赖于 natbib 宏包
\bibpunct{[}{]}{,}{s}{}{,}
\renewcommand\NAT@citesuper[3]{\ifNAT@swa%
	\unskip\kern\p@\textsuperscript{\NAT@@open #1\NAT@@close}%
	\if*#3*\else\ (#3)\fi\else #1\fi\endgroup}
\DeclareRobustCommand\onlinecite{\@onlinecite}
\def\@onlinecite#1{\begingroup\let\@cite\NAT@citenum\citep{#1}\endgroup}



% 参考文献条目学士论文最后加点
\def\bnudot{\ifbnu@bachelor\else\unskip.\fi}
\def\bnumasterbib{\ifbnu@doctor [M]\else [Master Thesis]\fi}
\def\bnuphdbib{\ifbnu@doctor [D]\else [Doctor Thesis]\fi}


% 修改默认的 thebibliography 环境，增加一些调整代码
\def\bibleftdelim{[}
\def\bibrightdelim{]}
\def\@biblabel#1{\bibleftdelim #1\bibrightdelim}
\renewenvironment{thebibliography}[1]{%
	\bnu@chapter*{\bibname}%
	\wuhao[1.6]
	\list{\@biblabel{\@arabic\c@enumiv .}}%
			{\renewcommand{\makelabel}[1]{##1\hfill}
			\settowidth\labelwidth{0cm}
			%\setlength{\labelsep}{0.5em}
			%\setlength{\itemindent}{1em}
			%\setlength{\leftmargin}{0.5cm}
			\setlength{\listparindent}{2em}
			\addtolength{\itemsep}{-0.7em}
			\usecounter{enumiv}%
			\let\p@enumiv\@empty
			\renewcommand\theenumiv{\@arabic\c@enumiv}}%
		\sloppy\frenchspacing
		\clubpenalty4000
		\@clubpenalty \clubpenalty
		\widowpenalty4000%
		\interlinepenalty4000%
		\sfcode`\.\@m}
	{\def\@noitemerr
		{\@latex@warning{Empty `thebibliography' environment}}%
		\endlist\frenchspacing}



% 正文图表公式编号
\RequirePackage{chngcntr}
\RequirePackage{amsmath}
\RequirePackage{mathtools}
\newtagform{empty}{{式}}{}
\usetagform{empty}
\counterwithout{table}{chapter}
\counterwithout{figure}{chapter}
\renewcommand\theequation{（\thechapter-\@arabic\c@equation）}
\renewcommand\thetable{\@arabic \c@table}
\renewcommand\thefigure{\@arabic\c@figure}


% 附录格式
\RequirePackage{CJKnumb}
\let\bnu@appendix\appendix
\renewenvironment{appendix}{%
	\bnu@appendix
	\setcounter{table}{0}
	\setcounter{figure}{0}
	\renewcommand \thechapter { \@Roman\c@chapter} 				% 附录用罗马数字编码
	\gdef\@chapapp{\appendixname~\thechapter}
	\renewcommand\theequation{（\CJKnumber\c@equation）}			% 附录图表公式编号格式
	\renewcommand\thetable{\CJKnumber\c@table}
	\renewcommand\thefigure{\CJKnumber\c@figure}
	}{}



% 研究成果
\newenvironment{paper}{
	\bnu@chapter*{\bnu@paper@title}}{}


% 书脊
\newcommand{\shuji}[1][\bnu@ctitle]{
	\newpage\thispagestyle{empty}\ziju{0.4em}\fs\xiaosan
	\hfill\rotatebox{-90}{\hb@xt@ \textheight{#1\hfill\bnu@cauthor}}}



% 生成索引的一些命令，虽然我们暂时用不到
\iffalse
	\newcommand{\bs}{\symbol{'134}}				% Print backslash
	\newcommand{\cih}[1]{%
		\index{commands!#1@\texttt{\bs#1}}%
		\index{#1@\texttt{\hspace*{-1.2ex}\bs #1}}}
	\newcommand{\ci}[1]{\cih{#1}\texttt{\bs#1}}
	\newcommand{\pai}[1]{%
		\index{packages!#1@\textsf{#1}}%
		\index{#1@\textsf{#1}}%
		\textsf{#1}}
	\newcommand{\ei}[1]{%
		\index{environments!\texttt{#1}}%
		\index{#1@\texttt{#1}}%
		\texttt{#1}}
\newcommand{\wi}[1]{\index{#1}#1}
\fi


% 自定义命令和环境
% 改变字距
\newcommand*{\ziju}[1]{\renewcommand{\CJKglue}{\hskip #1}}
\newcommand{\pozhehao}{\kern0.3ex\rule[0.8ex]{2em}{0.1ex}\kern0.3ex}



% 定义破折号
\def\bnu@active@cjk{
	\count@=128
	\@whilenum\count@<254 \do{%
		\advance\count@ by 1
		\lccode`\~=\count@
		\catcode\count@=\active
		\lowercase{\def~{\kern1ex}}}}



% 在模板文档结束时即装入配置文件，这样用户就能在导言区进行相应的修改
\AtEndOfClass{\ifxetex\else\bnu@active@cjk\fi\input{bnuthesis.cfg}}



% caption 宏包会调用 ragged2e，ragged2e 又调用 everysel
\def\bnu@fixselectfont{%
	\ifx\@EverySelectfont@EveryHook\@undefined\else
	\DeclareRobustCommand{\selectfont}{%
		\ifx\f@linespread\baselinestretch
		\else
			\set@fontsize\baselinestretch\f@size\f@baselineskip
		\fi
		\xdef\font@name{%
			\csname\curr@fontshape/\f@size\endcsname}%
		\pickup@font
		\font@name
		\CJK@bold@false								% CJK addition
		\csname \curr@fontshape\endcsname			% everysel addition
		\@EverySelectfont@EveryHook
		\@EverySelectfont@AtNextHook
		\gdef\@EverySelectfont@AtNextHook{}			% end additions
		\size@update
		\enc@update}
	\fi}




% 设置一些 pdf 文档信息，依赖于 hyperref 宏包
\def\bnu@setup@pdfinfo{%
	\hypersetup{%
		pdftitle={\bnu@ctitle},
		pdfauthor={\bnu@cauthor},
		pdfsubject={\bnu@cdegree},
		pdfkeywords={\bnu@ckeywords},
		pdfcreator={\bnu@cauthor},
		pdfproducer={\bnuthesis}}}


% 把 CJK 环境放到合适的位置，同时自动开启 CJK
\ifxetex
	\AtBeginDocument{\CJKindent}
\else
	\def\bnu@beginCJK{%
		\bnu@fixselectfont%
		\begin{CJK*}{UTF8}{song}\CJKindent}
	\def\bnu@endCJK{\clearpage\end{CJK*}}
	\let\bnu@begindocumenthook\@begindocumenthook
	\let\bnu@enddocumenthook\@enddocumenthook
	\def\AtBeginDocument{\g@addto@macro\bnu@begindocumenthook}
	\def\AtEndDocument{\g@addto@macro\bnu@enddocumenthook}
	\def\@begindocumenthook{\bnu@begindocumenthook\bnu@beginCJK}
	\def\@enddocumenthook{\bnu@endCJK\bnu@enddocumenthook}
\fi


\AtEndOfClass{\sloppy\bnu@item@space}
\endinput



% End of file 'bnuthesis.cls'.
