# Simulador Digital de Produção de Vinho 🍷

Este projeto consiste no desenvolvimento de um sistema de automação para a linha de produção de vinhos (envase, vedação e inspeção), fundamentado no conceito de **Máquinas de Estados Finitos (MEF)**. O sistema foi projetado em **Verilog** e prototipado na placa FPGA **DE10-Lite**.

## 📋 Sobre o Projeto
O objetivo principal é substituir métodos manuais por uma solução robusta em hardware para coordenar o acionamento de motores, válvulas e gerenciar a contagem da produção.

O sistema controla as seguintes etapas:
* **Envase:** Ativação da válvula de enchimento ao detectar uma garrafa.
* **Vedação:** Aplicação de rolhas com gerenciamento automatizado de estoque.
* **Inspeção:** Controle de qualidade para aprovação ou descarte de garrafas.
* **Contagem:** Monitoramento de garrafas individuais e lotes de dúzias.

## 👩‍💻 Autoras
- Analuz Lima da Silva  
- Larissa Matos Barbosa  
- Vivian Martins Moura

## 🛠️ Arquitetura do Sistema
Para garantir estabilidade e evitar falhas (*glitches*), foi adotado o modelo de **Máquina de Moore**. O sistema é dividido em três blocos funcionais principais:

1.  **MEF Principal:** O controlador central que orquestra sensores e atuadores.
2.  **MEF das Rolhas:** Gerencia de forma autônoma o estoque e a reposição do dispensador.
3.  **MEF das Dúzias:** Responsável pela contagem de produção aprovada e fechamento de lotes.

### Módulos Auxiliares
* **Divisor de Frequência:** Reduz o clock de 50 MHz para aproximadamente 3 Hz, permitindo o acompanhamento humano das etapas.
* **Decodificador BCD-7 Segmentos:** Converte dados binários para exibição nos displays através do algoritmo *Double Dabble*.

## 🚀 Como Usar (Placa DE10-Lite)
O sistema opera de forma orquestrada pela MEF Principal, com intervenções pontuais do operador.

* **Botão Start:** Inicia o processo e zera a contagem de dúzias.
* **Chaves (Switches):** Simulam a presença de garrafa, nível de enchimento, vedação e aprovação no controle de qualidade.
* **Displays:** Mostram em tempo real a quantidade de rolhas no estoque, na prateleira e o total de dúzias produzidas.
* **LEDs:** Indicam o status do motor, válvulas, alarmes e o estado atual da MEF principal.

## 💻 Ferramentas Utilizadas
* **Linguagem:** Verilog (HDL).
* **Software de Síntese:** Quartus Prime Lite Edition 20.1.
* **Simulação:** CircuitVerse e Logisim.
* **Hardware:** FPGA Intel Altera DE10-Lite.

## 📄 Relatório completo
Para mais detalhes sobre o desenvolvimento do projeto, acesse o relatório completo

*Este projeto foi desenvolvido como parte da disciplina TEC 498 MI - Projeto de Circuitos Digitais na UEFS*
