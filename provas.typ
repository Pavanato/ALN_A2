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
  + $x_k = y_k / (||max(y_k)||)$

Por fim, o autovalor é dado por $lambda = ||max(y_k)||$.

== Exemplo

Dada a matriz $A = mat(1, 2; 2,1)$, calcule a segunda iteração do método da potência para o vetor inicial $x_0 = vec(1, 0)$.

*Solução:*

- $y_1 = A x_0 = mat(1, 2; 2, 1) vec(1, 0) = vec(1, 2)$

- $x_1 = y_1 / (||max(y_k)||) = vec(1/2, 1)$

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
