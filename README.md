# bnu-bachelor-thesis

模板格式已通过图书馆审核。

北京师范大学学士论文模板，基于[北师大学位论文Latex模板](http://gerry.lamost.org/blog/?p=811)和 GitHub 上的已有项目 [BNUBachelorThesis](https://github.com/xysmlx/BNUBachelorThesis) 修改。使用此模板需要先了解和掌握 Latex 和 Bibtex 基本知识，学习 Latex 可以参考北师大天文系余恒老师整理的 [LATEX 相关资源](http://202.112.85.96/wiki/doku.php/latex;resources)。

本模板不进行任何更新，所有问题请自行解决。

### 模板特点

相比于 [BNUBachelorThesis](https://github.com/xysmlx/BNUBachelorThesis) 的模板，本模板主要有以下修改：

1. 半角符号修改成全角符号
2. 封面排版格式修改至几乎和[北师大学士毕业论文模板](北师大学士毕业论文模板.pdf)一致，包括替换高清 BNU_name.jpg 图片以及段落间距的调整等
3. 修改了 main.tex、cover.tex、buntils.sty、bnuthesis.cfg、bnuthesis.cls 等文件中的部分注释；主要根据[清华大学论文模板 v4.5.1](清华大学论文模板.pdf)，添加了 bnuthesis.cls 的注释，方便未来的使用者 debug
4. 使用 GB/T 7714-2015 参考文献著录规则，文件 gbt7714.sty、gbt7714-plain.bst、gbt7714-unsrt.bst 为参考文献格式文件，这一部分参考 GitHub 项目 [gbt7714-bibtex-style](https://github.com/CTeX-org/gbt7714-bibtex-style)

需要注意的是本版本针对 MacBook 进行过一些优化，没有在 Windows 系统中进行过编译，并不清楚在 Windows 系统中是否能成功编译。

### 编译说明

1. 模板主要针对 MacBook 用户，下载模板之后，务必安装文件夹 fonts 中的字体
2. 需要使用 Texlive 2012 的版本。MacBook 用户可以根据 http://www.tug.org/mactex/faq/3-4.html 中的指示下载 MacTeX 2012，如果速度过慢，也可以到[我的网盘](https://pan.baidu.com/s/1Qarn0dDzpgtmZ2i8wCZCIQ)中下载 mactex20120701.pkg 并进行安装
3. 必须使用 XeLaTeX 编译引擎进行编译（这里我不清楚为什么 pdfLaTeX 在我的电脑上无法编译）才能编译通过
4. 关于 bibtex 的相关知识可以自行维基，gbt7714 使用方法可以参考 GitHub 项目 [gbt7714-bibtex-style](https://github.com/CTeX-org/gbt7714-bibtex-style) 的项目主页，也可以直接查看 [gbt7714.pdf](gbt7714.pdf) 文件
5. 直接打开 main.pdf 查看模板使用方法



