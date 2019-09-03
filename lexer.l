%option noyywrap
%array
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <stdbool.h>
    #include "parser.tab.h"
    extern FILE *yyin;
    extern FILE *yyout;
    bool detect_unprintable(char *str,int n);
    void yyerror();
%}

DTD                                                 "<!DOCTYPE"[^>]*>
COMMENT                                             "<!--"([^-]|-[^-]|--+[^>])*-*"-->"

%%
{DTD}                                               {
                                                        yylval.str_val = malloc(yyleng*sizeof(char));
                                                        strcpy(yylval.str_val, yytext);
                                                    }
{COMMENT}                                           {
                                                        yylval.str_val = malloc(yyleng*sizeof(char));
                                                        strcpy(yylval.str_val, yytext);
                                                    } 
"<"                                                 {
                                                        yylval.str_val = malloc(yyleng*sizeof(char));
                                                        strcpy(yylval.str_val, yytext);
                                                        return beginStartTag;
                                                    } 
">"                                                 {
                                                        yylval.str_val = malloc(yyleng*sizeof(char));
                                                        strcpy(yylval.str_val, yytext);
                                                        return finishTag;
                                                    } 
"/>"                                                {
                                                        yylval.str_val = malloc(yyleng*sizeof(char));
                                                        strcpy(yylval.str_val, yytext);
                                                        return finishSelfClosingTag;
                                                    }
"</"                                                {   
                                                        yylval.str_val = malloc(yyleng*sizeof(char));
                                                        strcpy(yylval.str_val, yytext);
                                                        return beginEndTag;
                                                    }   
(?i:"html"[^><]*)/">"                               {
                                                        yylval.str_val = malloc(strlen("html")*sizeof(char));
                                                        strcpy(yylval.str_val, "html");
                                                        return TAG;
                                                    } 
(?i:"head"([.\n]{-}[<>])*)/[^<]*">"                 {
                                                        yylval.str_val = malloc(strlen("head")*sizeof(char));
                                                        strcpy(yylval.str_val, "head");
                                                        return TAG;
                                                    } 
(?i:"title"([.\n]{-}[<>])*)/[^<]*">"                {
                                                        yylval.str_val = malloc(strlen("title")*sizeof(char));
                                                        strcpy(yylval.str_val, "title");    
                                                        return TAG;
                                                    }   
(?i:"body"[^>]*)/">"                                { 
                                                        yylval.str_val = malloc(strlen("body")*sizeof(char));
                                                        strcpy(yylval.str_val, "body");
                                                        return TAG;
                                                    }                                 
(?i:"center"[^>]*)/">"                              {
                                                        yylval.str_val = malloc(strlen("center")*sizeof(char));
                                                        strcpy(yylval.str_val, "center");    
                                                        return TAG;
                                                    } 
(?i:"br")/"/>"                                      {
                                                        yylval.str_val = malloc(strlen("br")*sizeof(char));
                                                        strcpy(yylval.str_val, "br");
                                                        return TAG;
                                                    } 
(?i:"p")/">"                                        {
                                                        yylval.str_val = malloc(strlen("p")*sizeof(char));
                                                        strcpy(yylval.str_val, "p");
                                                        return TAG;
                                                    } 
(?i:"h1"([.\n]{-}[<>])*)/[^<]*">"                   {
                                                        yylval.str_val = malloc(strlen("h1")*sizeof(char));
                                                        strcpy(yylval.str_val, "h1");
                                                        return TAG;
                                                    } 
(?i:"h2"([.\n]{-}[<>])*)/[^<]*">"                   {
                                                        yylval.str_val = malloc(strlen("h2")*sizeof(char));
                                                        strcpy(yylval.str_val, "h2");
                                                         return TAG;
                                                    } 
(?i:"h3"([.\n]{-}[<>])*)/[^<]*">"                   {
                                                        yylval.str_val = malloc(strlen("h3")*sizeof(char));
                                                        strcpy(yylval.str_val, "h3");
                                                        return TAG;
                                                    } 
(?i:"h4"([.\n]{-}[<>])*)/[^<]*">"                   {
                                                        yylval.str_val = malloc(strlen("h4")*sizeof(char));
                                                        strcpy(yylval.str_val, "h4");
                                                        return TAG;
                                                    }  
(?i:"ul"([.\n]{-}[<>])*)/[^<]*">"                   {
                                                        yylval.str_val = malloc(strlen("ul")*sizeof(char));
                                                        strcpy(yylval.str_val, "ul");
                                                        return TAG;
                                                    }  
(?i:"li"([.\n]{-}[<>])*)/[^<]*">"                   {
                                                        yylval.str_val = malloc(strlen("li")*sizeof(char));
                                                        strcpy(yylval.str_val, "li");
                                                        return TAG;
                                                    }  
(?i:"ol"([.\n]{-}[<>])*)/[^<]*">"                   {
                                                        yylval.str_val = malloc(strlen("ol")*sizeof(char));
                                                        strcpy(yylval.str_val, "ol");
                                                        return TAG;
                                                    } 
(?i:"dl")/">"                                       {
                                                        yylval.str_val = malloc(strlen("dl")*sizeof(char));
                                                        strcpy(yylval.str_val, "dl");
                                                        return TAG;
                                                    } 
(?i:"dt")/">"                                       {
                                                        yylval.str_val = malloc(strlen("dt")*sizeof(char));
                                                        strcpy(yylval.str_val, "dt");
                                                        return TAG;
                                                    } 
(?i:"dd")/">"                                        {
                                                        yylval.str_val = malloc(strlen("dd")*sizeof(char));
                                                        strcpy(yylval.str_val, "dd");
                                                        return TAG;
                                                    } 
(?i:"u")/">"                                        {
                                                        yylval.str_val = malloc(strlen("u")*sizeof(char));
                                                        strcpy(yylval.str_val, "u");
                                                        return TAG;
                                                    }  
(?i:"b")/">"                                        {
                                                        yylval.str_val = malloc(strlen("b")*sizeof(char));
                                                        strcpy(yylval.str_val, "b");
                                                        return TAG;
                                                    }  
(?i:"i")/">"                                        {
                                                        yylval.str_val = malloc(strlen("i")*sizeof(char));
                                                        strcpy(yylval.str_val, "i");
                                                        return TAG;
                                                    } 
(?i:"em")/">"                                       {
                                                        yylval.str_val = malloc(strlen("em")*sizeof(char));
                                                        strcpy(yylval.str_val, "em");
                                                        return TAG;
                                                    }  
(?i:"strong"([.\n]{-}[<>])*)/[^<]*">"               {
                                                        yylval.str_val = malloc(strlen("strong")*sizeof(char));
                                                        strcpy(yylval.str_val, "strong"); 
                                                        return TAG;
                                                    } 
(?i:"sub"([.\n]{-}[<>])*)/[^<]*">"                  {
                                                        yylval.str_val = malloc(strlen("sub")*sizeof(char));
                                                        strcpy(yylval.str_val, "sub");
                                                        return TAG;
                                                    }  
(?i:"sup"([.\n]{-}[<>])*)/[^<]*">"                  {
                                                        yylval.str_val = malloc(strlen("sup")*sizeof(char));
                                                        strcpy(yylval.str_val, "sup");    
                                                        return TAG;
                                                    } 
(?i:"table"[^<>]*)/">"                              {
                                                        yylval.str_val = malloc(strlen("table")*sizeof(char));
                                                        strcpy(yylval.str_val, "table");
                                                        return TAG;
                                                    } 
(?i:"th"([.\n]{-}[<>])*)/[^<]*">"                   {
                                                        yylval.str_val = malloc(strlen("th")*sizeof(char));
                                                        strcpy(yylval.str_val, "th");
                                                        return TAG;
                                                    } 
(?i:"tr"([.\n]{-}[<>])*)/[^<]*">"                   {
                                                        yylval.str_val = malloc(strlen("tr")*sizeof(char));
                                                        strcpy(yylval.str_val, "tr");
                                                        return TAG;
                                                    } 
(?i:"td"([.\n]{-}[<>])*)/[^<]*">"                   {
                                                        yylval.str_val = malloc(strlen("td")*sizeof(char));
                                                        strcpy(yylval.str_val, "td");
                                                        return TAG;
                                                    } 
(?i:"caption"([.\n]{-}[<>])*)/[^<]*">"              {
                                                        yylval.str_val = malloc(strlen("caption")*sizeof(char));
                                                        strcpy(yylval.str_val, "caption");
                                                        return TAG;
                                                    }  
(?i:"div"([.\n]{-}[<>])*)/[^<]*">"                  {
                                                        yylval.str_val = malloc(strlen("div")*sizeof(char));
                                                        strcpy(yylval.str_val, "div");
                                                        return TAG;
                                                    }  
  
(?i:"small"([.\n]{-}[<>])*)/[^<]*">"                {
                                                        yylval.str_val = malloc(strlen("small")*sizeof(char));
                                                        strcpy(yylval.str_val, "small");
                                                        return TAG;
                                                    } 
(?i:"tt"([.\n]{-}[<>])*)/[^<]*">"                   {
                                                        yylval.str_val = malloc(strlen("tt")*sizeof(char));
                                                        strcpy(yylval.str_val, "tt");
                                                        return TAG;                                                    }
(?i:"tbody"([.\n]{-}[<>])*)/[^<]*">"                {
                                                        yylval.str_val = malloc(strlen("tbody")*sizeof(char));
                                                        strcpy(yylval.str_val, "tbody");
                                                        return TAG;
                                                    }                                 
[^<>]*/"<"                                          {
                                                        yylval.str_val = malloc(yyleng*sizeof(char));
                                                        strcpy(yylval.str_val, yytext);
                                                        if (detect_unprintable(yytext,strlen(yytext)))
                                                        return RAWTEXT;
                                                    }
(?i:"img")/[^<>]*">"                               {
                                                        yylval.str_val = malloc(strlen("img")*sizeof(char));
                                                        strcpy(yylval.str_val, "img");
                                                        return TAG;
                                                    }
"src"/[^<>]*>                                       {
                                                        yylval.str_val = malloc(strlen("src")*sizeof(char));
                                                        strcpy(yylval.str_val, "src");
                                                        return ATTRIBUTE;
                                                    }
"width"/[^<>]*>                                     {
                                                        yylval.str_val = malloc(strlen("width")*sizeof(char));
                                                        strcpy(yylval.str_val, "width");
                                                        return ATTRIBUTE;
                                                    }
"height"/[^<>]*>                                    {
                                                        yylval.str_val = malloc(strlen("height")*sizeof(char));
                                                        strcpy(yylval.str_val, "height");
                                                        return ATTRIBUTE;
                                                    }
"figure"/[^<>]*>                                    {
                                                        yylval.str_val = malloc(strlen("figure")*sizeof(char));
                                                        strcpy(yylval.str_val, "figure");
                                                        return ATTRIBUTE;
                                                    }
"figcaption"/[^<>]>                                 {
                                                        yylval.str_val = malloc(strlen("figcaption")*sizeof(char));
                                                        strcpy(yylval.str_val, "figcaption");
                                                        return ATTRIBUTE;
                                                    }                                                                                                                                                                                                                                                                                 
(?i:"font")/[^<>]*">"                               {
                                                        yylval.str_val = malloc(strlen("font")*sizeof(char));
                                                        strcpy(yylval.str_val, "font");  
                                                        return TAG;
                                                    }
"size"/[^<]*"</font>"                               {
                                                        yylval.str_val = malloc(strlen("size")*sizeof(char));
                                                        strcpy(yylval.str_val, "size");
                                                        return ATTRIBUTE;
                                                    }
(?i:"a ")/[^<>]*">"                                 {
                                                        yylval.str_val = malloc(strlen("a")*sizeof(char));
                                                        strcpy(yylval.str_val, "a");
                                                        return TAG;                                                   
                                                    }
(?i:"a")/">"                                        {
                                                        yylval.str_val = malloc(strlen("a")*sizeof(char));
                                                        strcpy(yylval.str_val, "a");
                                                        return TAG;                                                  
                                                    }                                                    
"href"/[^<>]*>                                      {
                                                        yylval.str_val = malloc(strlen("href")*sizeof(char));
                                                        strcpy(yylval.str_val, "href");
                                                        return ATTRIBUTE;
                                                    }             
"name"/[^<>]*>                                      {
                                                        yylval.str_val = malloc(strlen("href")*sizeof(char));
                                                        strcpy(yylval.str_val, "name");
                                                        return ATTRIBUTE;
                                                    }
"="/\"[^\"]*\"[^<>]*>                               {
                                                        yylval.str_val = malloc(yyleng*sizeof(char));
                                                        strcpy(yylval.str_val, yytext);
                                                        return ATTRIBUTE_ASSIGN;
                                                    }
\"[^<>]*\"/[^<>]*">"                                {
                                                        yylval.str_val = malloc(yyleng*sizeof(char));
                                                        strcpy(yylval.str_val, yytext);
                                                        return ATTRIBUTE_VALUE; 
                                                    }
"<meta"[^>]*>       
.                                                   {}
"\n"                                                {}
%%

bool detect_unprintable(char *str,int n)
{
    for (int c=0;c<n;c++)
    {
        if (str[c]>32){return true;}
    
    }
    return false;
}