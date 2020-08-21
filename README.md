# STMap

- Douglas P. Pasqualin
- [dp.pasqualin@inf.ufpel.edu.br](mailto:dp.pasqualin@inf.ufpel.edu.br)
- UFSM / UFPel

An online, low overhead mechanism to detect the sharing behavior and perform the mapping directly inside the STM library, by tracking and analyzing how threads perform STM operations.

## TinySTM

### Makefile

Configurações adicianadas a compilação da TinySTM:

`DEFINES += -DINSTRUMENT=OFF`: Desabilita o monitoramento dos conjuntos de read e write [r/w] pra montar a matriz de comunicação.

`DEFINES += -DINSTRUMENT=METHOD1`: Habilita o monitoramento dos conjuntos de r/w pra montar a matriz de comunicação.

-  *Usando `DEFINES += -DINSTRUMENT=METHOD1` precisa utilizar outro parâmetro para monitorar todos r/w ou por amostragem:*
  - `DEFINES += -DSAMPLE_INTERVAL=100`: Utilizando valor `0` monitoramos todos os conjuntos de r/w.

`DEFINES += -DINSTRUMENT=ONLINE`: Monta a matriz de comunicação e faz o thread mapping durante a execução.

- Pra compilar com este parametro ativo, precisa utilizar a lib [topomatch](https://gitlab.inria.fr/ejeannot/topomatch).

`DEFINES += -DBIND_THREAD=LINUX_DEFAULT`.

---

**No final da execução a saída fornecerá uma matriz de comunicação em csv com suas estatisticas.**