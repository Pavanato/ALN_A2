#import "theorems.typ": *
#show: thmrules.with(qed-symbol: $square$)

#set page(numbering: "1")

// #set page(margin: 1.5cm)
#set text(font: "Linux Libertine", lang: "pt")
#set heading(numbering: "1.")

#let theorem = thmbox("teorema", "Teorema", fill: rgb("#eeffee"))
#let corollary = thmbox(
  "Corolário",
  "Corolário",
  base: "teorema",
  fill: rgb("#f8e8e8"),
  titlefmt: strong
)
#let definition = thmbox(
  "definição", 
  "Definição", 
  // inset: (x: 1.2em, top: 1em),
  fill: rgb("#e7e7e7")
  )

#let example = thmplain("exemplo", "Exemplo").with(numbering: none)
#let proof = thmproof("prova", "Prova", titlefmt: strong)

#set heading(numbering: "1.")


// resumo algebra linear numerica

= Método da Potência 

Dado um vetor inicial $x_0$, o método da potência itera a multiplicação da matriz $A$ pelo vetor $x_(k-1)$, normaliza o resultado e repete o processo até que a sequência $x_k$ convirja para um vetor próprio de $A$. O algoritmo é dado por:

+ Escolha um vetor inicial $x_0$.
+ Para $k = 1, 2, 3, ...$ faça:
  + $y_k = A x_(k-1)$
  + $x_k = y_k / (max(y_k))$

Por fim, o autovalor é dado por $lambda = max(y_k)$. Onde $max(y_k)$ é o maior valor absoluto de $y_k$.

== Exemplo

Dada a matriz $A = mat(1, 2; 2,1)$, calcule a segunda iteração do método da potência para o vetor inicial $x_0 = vec(1, 0)$.

*Solução:*

- $y_1 = A x_0 = mat(1, 2; 2, 1) vec(1, 0) = vec(1, 2)$

- $x_1 = y_1 / (max(y_1)) = vec(1/2, 1)$

- $y_2 = A x_1 = mat(1, 2; 2, 1) vec(1/2, 1) = vec(5/2, 2)$


Portanto, a aproximação do autovalor é $lambda = 5/2$.

= Discos de Gerschgorin

Dada uma matriz $A$, os discos de Gerschgorin são regiões circulares no plano complexo que contêm todos os autovalores de $A$. Cada disco é centrado no elemento $a_(i i)$ da diagonal principal e tem raio igual à soma dos módulos dos elementos da linha $i$ que não pertencem à diagonal principal. 

== Exemplo

Dada a matriz $A = mat(1, 1, -1; 1, 3, 2; 3, 2, 5)$, calcule os discos de Gerschgorin. Imagem:

#figure(image("gersh1.png", width: 40%), caption: [
    Discos de Gerschgorin para a matriz $A$
])

#figure(image("gersh2.png", width: 40%), caption: [
    Discos de Gerschgorin para a matriz $A^T$
])

= Mínimos Quadrados

Dado um sistema linear $A x = b$, o problema dos mínimos quadrados consiste em encontrar o vetor $hat(x)$ que minimiza a norma do resíduo $r = b - A x$. A solução é dada por $(A^T A)hat(x) = A^T b$.

== Exemplo

Dado o sistema linear $A x = b$, onde $A = mat(1, 1; 1, 2; 1, 3)$ e $b = vec(2, 3, 3)$, calcule a solução do problema dos mínimos quadrados.

*Solução:*

$ A^T A = mat(1, 1, 1; 1, 2, 3) mat(1, 1; 1, 2; 1, 3) = mat(3, 6; 6, 14) $

$ A^T b = mat(1, 1, 1; 1, 2, 3) vec(2, 3, 3) = vec(8, 16) $

$ (A^T A)hat(x) = A^T b ==> mat(3, 6; 6, 14)hat(x) = vec(8, 16) $

$ hat(x) = mat(3, 6; 6, 14)^(-1) vec(8, 16) = 1/6 mat(14, -6; -6, 3) vec(8, 16) = vec(8/3, 0) $

Testando a solução:

$ A hat(x) = mat(1, 1; 1, 2; 1, 3) vec(8/3, 0) = vec(8/3, 8/3, 8/3) $


= Decomposição QR

Dada uma matriz $A$, a decomposição QR consiste em encontrar uma matriz ortogonal $Q$ e uma matriz triangular superior $R$ tal que $A = Q R$. A matriz $Q$ é obtida a partir da ortogonalização de Gram-Schmidt e a matriz $R$ é obtida a partir da multiplicação de $Q^T A$.

== Exemplo

Dada a matriz $A = mat(1, 1; 1, 2; 1, 3)$, calcule a decomposição QR.

*Solução:*

Vetor $a_1 = vec(1, 1, 1)$

$ q_1 = a_1 / (||a_1||) = vec(1/sqrt(3), 1/sqrt(3), 1/sqrt(3)) $

$ a_2 = vec(1, 2, 3) -  <q_1, a_2> q_1 = vec(1, 2, 3) - (6/sqrt(3))(1/sqrt(3)) vec(1, 1, 1) = vec(-1, 0, 1) $

$ q_2 = a_2 / (||a_2||) = vec(-1/sqrt(2), 0, 1/sqrt(2)) $

$ a_3 = q_1 times q_2 = vec(1/sqrt(3), 1/sqrt(3), 1/sqrt(3)) times vec(-1/sqrt(2), 0, 1/sqrt(2)) = vec(1/sqrt(6), -2/sqrt(6), 1/sqrt(6)) $

Portanto, a matriz $Q$ é dada por:

$ Q = mat(1/sqrt(3), -1/sqrt(2), 1/sqrt(6); 1/sqrt(3), 0, -2/sqrt(6); 1/sqrt(3), 1/sqrt(2), 1/sqrt(6)) $

A matriz $R$ é obtida a partir da multiplicação $Q^T A$:

$ R = Q^T A = mat(1/sqrt(3), 1/sqrt(3), 1/sqrt(3); -1/sqrt(2), 0, 1/sqrt(2); 1/sqrt(6), -2/sqrt(6), 1/sqrt(6)) mat(1, 1; 1, 2; 1, 3) = mat(sqrt(3), 2 sqrt(3); 0, sqrt(2); 0, 0) $

= Decomposição em Valores Singulares

Dada uma matriz $A$, a decomposição em valores singulares consiste em encontrar três matrizes $U$, $Sigma$ e $V$ tais que $A = U Sigma V^T$, onde $U$ e $V$ são ortogonais e $Sigma$ é uma matriz diagonal com os autovalores de $A$.

== Exemplo

Dada a matriz $A = mat(1, 0; 1, 1; -1, 1)$, calcule a decomposição em valores singulares.

*Solução:*

A matriz $A^T A$ é dada por:

$ A^T A = mat(1, 1, -1; 0, 1, 1) mat(1, 0; 1, 1; -1, 1) = mat(3, 0; 0, 2) $

Os autovalores de $A^T A$ são $lambda_1 = 3$ e $lambda_2 = 2$. Os autovetores correspondentes são $v_1 = vec(1, 0)$ e $v_2 = vec(0, 1)$.

A matriz $V$ é dada por:

$ V = mat(1, 0; 0, 1) $

A matriz $A A^T$ é dada por:

$ A A^T = mat(1, 0; 1, 1; -1, 1) mat(1, 1, -1; 0, 1, 1) = mat(1, 1, -1; 1, 2, 0; -1, 0, 2) $

Os autovalores de $A A^T$ são $lambda_1 = 3$, $lambda_2 = 2$ e $lambda_3 = 0$. Os autovetores correspondentes são:

$ u_1 = vec(-1, -1, 1)", " u_2 = vec(0, 1, 1) "e " u_3 = vec(2, -1, 1) $

Normalizando os autovetores, obtemos:

$ u_1 = vec(-1/sqrt(3), -1/sqrt(3), 1/sqrt(3)) ", " u_2 = vec(0, 1/sqrt(2), 1/sqrt(2)) "e " u_3 = vec(2/sqrt(6), -1/sqrt(6), 1/sqrt(6)) $

Portanto, a matriz $U$ é dada por:

$ U = mat(-1/sqrt(3), 0, 2/sqrt(6); -1/sqrt(3), 1/sqrt(2), -1/sqrt(6); 1/sqrt(3), 1/sqrt(2), 1/sqrt(6)) $

A matriz $Sigma$ é dada por:

$ Sigma = mat(sqrt(3), 0; 0, sqrt(2);0,0) $

Portanto, a decomposição em valores singulares de $A$ é dada por:

$ A = mat(1/sqrt(3), 0, 2/sqrt(6); -1/sqrt(3), 1/sqrt(2), -1/sqrt(6); 1/sqrt(3), 1/sqrt(2), 1/sqrt(6)) mat(sqrt(3), 0; 0, sqrt(2);0,0) mat(1, 0; 0, 1)^T $

= Pseudo-Inversa

Dada uma matriz $A$, a pseudo-inversa $A^+$ é uma generalização da inversa de $A$ para matrizes não quadradas. A pseudo-inversa é dada por $A^+ = V Sigma^+ U^T$, onde $U$, $Sigma$ e $V$ são as matrizes da decomposição em valores singulares de $A$.

Onde $Sigma^+$ é a pseudo-inversa de $Sigma$, obtida substituindo os elementos não nulos de $Sigma$ por seus inversos e transpondo a matriz resultante.

== Exemplo

Usando o exemplo anterior, calcule a pseudo-inversa da matriz $A = mat(1, 0; 1, 1; -1, 1)$.

Já calculamos a decomposição em valores singulares de $A$, então basta calcular a pseudo-inversa:

$ Sigma^+ = mat(1/sqrt(3), 0; 0, 1/sqrt(2);0,0)^T = mat(1/sqrt(3), 0,0; 0, 1/sqrt(2),0) $

Portanto, a pseudo-inversa de $A$ é dada por:


$ A^+ &= mat(1, 0; 0, 1) mat(1/sqrt(3), 0,0; 0, 1/sqrt(2),0) mat(1/sqrt(3), 0, 2/sqrt(6); -1/sqrt(3), 1/sqrt(2), -1/sqrt(6); 1/sqrt(3), 1/sqrt(2), 1/sqrt(6))^T \
&= mat(1/3, 1/3, -1/3; 0, 1/2, 1/2) $

Podemos checar que a pseudo-inversa de $A$ é correta verificando que $A^+ A = I$:

$ A^+ A = mat(1/3, 1/3, -1/3; 0, 1/2, 1/2) mat(1, 0; 1, 1; -1, 1) = mat(1, 0; 0, 1) $

= Householder

A transformação de Householder é uma transformação ortogonal que zera todos os elementos de um vetor, exceto o primeiro. Dada uma matriz $A$ e um vetor $x$, a transformação de Householder é dada por:

$ H = I - 2 u u^T $

Onde $u = (x - ||x|| e_1)/(||x - ||x|| e_1||)$, $e_1$ é o primeiro vetor da base canônica e $||x||$ é a norma de $x$.

== Exemplo

Dada a matriz $A$, calcule a transformação de Householder que zera os elementos da primeira coluna, exceto o primeiro.

*Solução:*

Seja $a_1$ a primeira coluna de $A$. O vetor $u$ é dado por $u = (a_1 - ||a_1|| e_1)/(||a_1 - ||a_1|| e_1||)$. A matriz $H$ é dada por:

$ H = I - 2 u u^T $

Onde aplicamos a transformação de Householder em $A$:

$ H dot A $

Se quiser ver isso com uma matriz $A$ verdade, faça a questão $4)b)$ da prova de $2022$