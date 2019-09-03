#pragma once
#include "node.h"
extern char *out_file;
extern FILE *fp;

// Used to replace the greek letters from the text.
char *replaceWord(const char *s, const char *oldW, const char *newW) 
{ 
    char *result; 
    int i, cnt = 0; 
    int newWlen = strlen(newW); 
    int oldWlen = strlen(oldW); 
  
    // Counting the number of times old word 
    // occur in the string 
    for (i = 0; s[i] != '\0'; i++) 
    { 
        if (strstr(&s[i], oldW) == &s[i]) 
        { 
            cnt++; 
  
            // Jumping to index after the old word. 
            i += oldWlen - 1; 
        } 
    } 
  
    // Making new string of enough length 
    result = (char *)malloc(i + cnt * (newWlen - oldWlen) + 1); 
  
    i = 0; 
    while (*s) 
    { 
        // compare the substring with the result 
        if (strstr(s, oldW) == s) 
        { 
            strcpy(&result[i], newW); 
            i += newWlen; 
            s += oldWlen; 
        } 
        else
            result[i++] = *s++; 
    } 
  
    result[i] = '\0'; 
    return result; 
}  

// Used to replace greek letters.
char * greek_letters(char * a)
{
    strcpy(a,replaceWord(a, "&Alpha", "$\\alpha$"));
    strcpy(a,replaceWord(a, "&Gamma", "$\\gamma$"));
    strcpy(a,replaceWord(a, "&Theta", "$\\theta$"));
    strcpy(a,replaceWord(a, "&Xi", "$\\xi$"));
    strcpy(a,replaceWord(a, "&Pi", "$\\pi$"));
    printf("ff\n");
    return a;
}





//********************************************************************************************************************//
//********************************************************************************************************************//





// Returns the mapping code to the function post order.
void map(struct ast_node* a,char *t,char *v)
{
    if(strcmp(v,"a")==0){
      a->front="";
      a->end="";
    }

    else if(strcmp(v,"b")==0)
    {
        a->front="\\textbf{";
        a->end="}";
    }

    else if(strcmp(v,"body")==0){
        a->front = "\n";
        a->end="";
    }
  
    else if(strcmp(v,"br")==0)
    {
        a->front="\\newline";
        a->end="";
    }

    else if(strcmp(v,"caption")==0)
    {
        a->front="";
        a->end="";
    }

    else if (strcmp(v,"center")==0)
    {
        a->front="\\begin{center}";
        a->end="\\end{center}";
    }
    else if (strcmp(v,"dd")==0)
    {
        a->front="\n";
        a->end="";

    }
    else if (strcmp(v,"div")==0)
    {
        a->front="\\newline\n";
        a->end="\\newline\n";
    }
    else if (strcmp(v,"dl")==0)
    {
        a->front = "\\begin{description}";
        a->end = "\\end{description}";
    }
    
    else if (strcmp(v,"dt")==0)
    {
        a->front=("\\item[");
        a->end="]";
    }

    else if (strcmp(v,"em")==0)
    {
        a->front="\\emph{";
        a->end="}";
    }

    else if (strcmp(v,"figcaption")==0)
    {
        a->front="";
        a->end="";
    }

    else if (strcmp(v,"figure")==0)
    {
        a->front="";
        a->end="";
    }
 
    else if(strcmp(v,"font")==0){
        a->front = "{\\fontsize{"; 
        a->end = "}";
   }
  
    else if (strcmp(v,"i")==0)
    {
        a->front="\\textit{";
        a->end="}";
    }

    else if (strcmp(v,"h1")==0)
    {
        a->front="\\section*{";
        a->end="}\n";
    }
  
    else if (strcmp(v,"h2")==0)
    {
        a->front="\\subsection*{";
      a->end="}\n";
    }
 
    else if (strcmp(v,"h3")==0)
    {
        a->front="\\subsubsection*{";
        a->end="}\n";
    }
   
   else if (strcmp(v,"h4")==0)
    {
        a->front="\\subparagraph*{";
        a->end="}\n";
    }
  
    else if (strcmp(v,"head")==0||strcmp(v,"name")==0)
    {
        a->front="";
        a->end="";
    }
  
    else if (strcmp(v,"height")==0)
    {
        a->front="";
        a->end="";
    }
    
    else if (strcmp(t,"href")==0)
    {
        char *temp5 =malloc(strlen(v)+1);
        int c=1;
        int j=0;
        while(c<strlen(v)){
        if(v[c]!='\"'){
            printf("%c", v[c]);
            temp5[j]=v[c];
            j++;
        }
        else{
          break;
        }
        c++;
        }
        char *x = malloc(strlen(v)+1);
        strcpy(x,"\\href{");
        strcat(x,temp5);
        strcat(x,"}");
        a->front = malloc(strlen(x)+1);
        strcpy(a->front,x);
        a->end="{";
    }
    else if(strcmp(v,"html")==0)
    {
        a->front="\\documentclass{article}\n\\usepackage{graphicx}\n\\usepackage{hyperref}\n\\usepackage[utf8]{inputenc}\n\\inputencoding{utf8}\n\\title{COP701}\n\\author{ee3170539}\n\\date{September 2019}\n\\begin{document}\n";
        a->end="\\end{document}";
    }

    else if (strcmp(v,"img")==0 && strcmp(t,"TAG")==0)
    {
        a->front="\\includegraphics{";
        a->end="}";
    }

    else if (strcmp(v,"li")==0)
    {
        a->front=("\\item");
        a->end="";
    }

    else if(strcmp(t,"name")==0)
    {
        a->front = "";
        a->end="";
    }
   
   else if (strcmp(v,"ol")==0)
    {
        a->front = "\\begin{enumerate}";
        a->end = "\\end{enumerate}";
    }
  
    else if (strcmp(v,"p")==0)
    {
        a->front="\\paragraph{}";
        a->end="";
    }
    else if(strcmp(t,"RAWTEXT")==0)
    {
        char *temp3=malloc(strlen(v)*3);
        int j=0;
        for (int c=0;c<strlen(v);c++)
        {
      
            if(v[c]=='#' || v[c]=='$' || v[c]=='{' || v[c]=='}' || v[c]=='^' || v[c]=='@' || v[c]=='%' || v[c]=='~' || v[c]=='_'){
            temp3[j] = '\\';
            j++;
            if(v[c] >= 32 && v[c]<127){
                temp3[j] = v[c];
                j++;
            }
            }
        
            else if(v[c]=='\\'){
                temp3 = strcat(temp3, "\\textbackslash");
                j+=14;
            }
        
            else{
                if(v[c] >= 32 && v[c]<127){
                    temp3[j] = v[c];
                    j++;
                }
            }
        }
        temp3[j]='\0';
        temp3 = greek_letters(temp3);
    
        a->front = temp3;
        a->end=" ";
      
    }
    else if(strcmp(t,"size")==0){
        char *temp=malloc(strlen(v)+1);
        int c=0;
        int j=0;
        while(c<strlen(v)){
          if(v[c]!='\"'){
            printf("%c", v[c]);
            temp[j]=v[c];
            j++;
          }
          c++;
        }
        a->front = strcat(temp, "}{10}\\selectfont ");
        a->end = " ";
    }
    else if (strcmp(v,"small")==0)
    {
        a->front=malloc(9);
        a->front="\\small{";
        a->end="} ";
    }
    
    else if (strcmp(t,"src")==0)
    {
        char *temp=malloc(strlen(v)+1);
        int c=0;
        int j=0;
        while(c<strlen(v)){
          if(v[c]!='\"'){
            temp[j]=v[c];
            j++;
          }
          c++;
        }
        a->front= temp;
        a->end="";
    }

    else if (strcmp(v,"strong")==0)
    {
        a->front="\\textbf{";
        a->end="}";
    }
   
    else if (strcmp(v,"sub")==0)
    {
        a->front="$_{";
        a->end="}$";
    }

    else if (strcmp(v,"sup")==0)
    {
        a->front="$^{";
        a->end="}$";
    }
  
    else if (strcmp(v,"table")==0)
    {
        a->front="";
        a->end="\\hline\\end{tabular}\\newline";
    }
  
    else if (strcmp(v,"tbody")==0)
    {
        a->front="";
        a->end="";
    } 
   
    else if (strcmp(v,"td")==0)
    {
        a->front="";
        a->end="";
    }
   
   else if (strcmp(v,"th")==0)
    {
        a->front="";
        a->end="";
    }
  
    else if(strcmp(v,"title")==0){
        a->front="\n\\maketitle\n\%";
        a->end="\n";
    }
 
    else if (strcmp(v,"tr")==0)
    {
        a->front="\n";
        a->end="\\\\";
    }
 
    else if (strcmp(v,"tt")==0)
    {
        a->front="\\texttt{";
        a->end="}";
    }
  
    else if (strcmp(v,"u")==0)
    {
        a->front="\\underline{";
        a->end="}";
    }
  
    else if (strcmp(v,"ul")==0)
    {
        a->front  ="\\begin{itemize}";
        a->end = "\\end{itemize}";
    }
  
    else if (strcmp(v,"width")==0)
    {
        a->front="";
        a->end="";
    }
  
 
 

  
  


}

