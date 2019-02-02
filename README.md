# OS-Dev

## Bootloader
### System start

#### Bios
Befehlssatz ist immer 8086 - 16 Bit und im Real-Mode

- Bios:
  1. System check ob alle Componenten vorhanden sind
  2. such nach dem Bootloader/Bootmanager auf dem "Master Boot Record" (MBR)
  3. Läd es in den Ram und spring zu der Addresse
  4. Jetzt setzt die CPU ein
 
### Master Boot Record
 - Enthält das Startprogramm und die Partitionstabelle
 - Liegt im Track 0 Side 0 Sector 0
 - Am ende muss 0x55AA stehe<br/>
Der Speicheraufbaue der MBR ist wie folgt 

| Stage 1 Bootloader | Master Partition Enty 0 | Master Partition Enty 1 | Master Partition Enty n | Magic number |
| ------------------ | ----------------------- | ----------------------- | ----------------------- | ------------ |
<br/>
<table border="0">
 <tr>
    <td align="center" colspan="2"><b>Addr.</b>
    <td align="center" rowspan="2" colspan="2"><b>Function<br/>Inhalt</b></td>
    <td align="center" rowspan="2"><b>Size<br/>(Byte)</b></td>
 </tr>
 <tr>
    <td align="center">Hex</td>
    <td align="center">Dez</td>
 </tr>
 <tr>
    <td align="center">0x0000</td>
    <td align="center">0</td>
    <td colspan="2">Startprogamm(bootloader)</td>
    <td align="center">440</td>
 </tr>
 <tr>
    <td align="center">0x01B8</td>
    <td align="center">440</td>
    <td colspan="2">Datenträger Signatur</td>
    <td align="center">4</td>
 </tr>
 <tr>
    <td align="center">0x01BC</td>
    <td align="center">444</td>
    <td colspan="2">Null (0x0000)</td>
    <td align="center">2</td>
 </tr> 
 <tr>
    <td align="center">0x01BE</td>
    <td align="center">446</td>
    <td colspan="2">Partitionstabelle</td>
    <td align="center">64</td>
 </tr>
 <tr>
    <td align="center">0x01FE</td>
    <td align="center">510</td>
    <td align="center">55<sub>hex</sub></td>
    <td rowspan="2">Bootsektor-Signatur</td>
    <td rowspan="2" align="center">2</td>
 </tr>
 <tr >
    <td align="center">0x01FE</td>
    <td align="center">511</td>
    <td align="center">AA<sub>hex</sub></td>
 </tr>
   <tr>
  <td colspan="4">Gesammt:</td>
  <td align="center">512</td>
   </tr>
</table>

#### Partitions Tabelle 
| Flag  | Start CHS | Type  | End CHS | Start LBA | Size  |
| :---: | :-------: | :---: | :-----: | :-------: | :---: |
| 1Byte |   3Byte   | 1Byte |  3Byte  |   4Byte   | 4Byte |

#### Aufbau einer Partitionstabelle

Beispiel:
<table>
   <tr>
      <td>Offset</td>
      <td>*0</td> 
      <td>*1</td> 
      <td>*2</td> 
      <td>*3</td> 
      <td>*4</td> 
      <td>*5</td> 
      <td>*6</td> 
      <td>*7</td> 
      <td>*8</td> 
      <td>*9</td> 
      <td>*A</td> 
      <td>*B</td> 
      <td>*C</td> 
      <td>*D</td> 
      <td>*E</td> 
      <td>*F</td>
   </tr>
   <tr>
      <td  align="center" colspan="17">.  .  .</td>
   </tr>
   <tr>
      <td>0x01b0</td>
      <td>0x00</td> 
      <td>0x00</td> 
      <td>0x00</td> 
      <td>0x00</td> 
      <td>0x00</td> 
      <td>0x00</td> 
      <td>0x00</td> 
      <td>0x00</td> 
      <td>0x78</td> 
      <td>0x56</td> 
      <td>0x34</td> 
      <td>0x12</td> 
      <td>0x00</td> 
      <td>0x00</td> 
      <td style="background-color: #1E90FF; color: white">0x00</td> 
      <td style="background-color: #1E90FF; color: white">0x01</td>
   </tr>
   <tr>
      <td>0x01c0</td>
      <td style="background-color: #1E90FF; color: white">0x01</td> 
      <td style="background-color: #1E90FF; color: white">0x00</td> 
      <td style="background-color: #1E90FF; color: white">0x83</td> 
      <td style="background-color: #1E90FF; color: white">0xfe</td> 
      <td style="background-color: #1E90FF; color: white">0xff</td> 
      <td style="background-color: #1E90FF; color: white">0xff</td> 
      <td style="background-color: #1E90FF; color: white">0x3f</td> 
      <td style="background-color: #1E90FF; color: white">0x00</td> 
      <td style="background-color: #1E90FF; color: white">0x00</td> 
      <td style="background-color: #1E90FF; color: white">0x00</td> 
      <td style="background-color: #1E90FF; color: white">0x41</td> 
      <td style="background-color: #1E90FF; color: white">0x29</td> 
      <td style="background-color: #1E90FF; color: white">0x54</td> 
      <td style="background-color: #1E90FF; color: white">0x02</td> 
      <td>0x00</td> 
      <td>0xfe</td>
   </tr>
   <tr>
      <td align="center" colspan="17">.  .  .</td>
   </tr>
   <tr>
      <td>0x01e0</td>
      <td style="background-color: orange; color: white">0xff</td> 
      <td style="background-color: orange; color: white">0xff</td> 
      <td style="background-color: orange; color: white">0x83</td> 
      <td style="background-color: orange; color: white">0xfe</td> 
      <td style="background-color: orange; color: white">0xff</td> 
      <td style="background-color: orange; color: white">0xff</td> 
      <td style="background-color: orange; color: white">0x7a</td> 
      <td style="background-color: orange; color: white">0x11</td> 
      <td style="background-color: orange; color: white">0x72</td> 
      <td style="background-color: orange; color: white">0x02</td> 
      <td style="background-color: orange; color: white">0xfa</td> 
      <td style="background-color: orange; color: white">0xe7</td> 
      <td style="background-color: orange; color: white">0x1d</td> 
      <td style="background-color: orange; color: white">0x00</td> 
      <td style="background-color: #1E90FF; color: white">0x80</td> 
      <td style="background-color: #1E90FF; color: white">0xfe</td>
   </tr>
   <tr>
      <td>0x01f0</td>
      <td style="background-color: #1E90FF; color: white">0xff</td> 
      <td style="background-color: #1E90FF; color: white">0xff</td> 
      <td style="background-color: #1E90FF; color: white">0x83</td> 
      <td style="background-color: #1E90FF; color: white">0xff</td> 
      <td style="background-color: #1E90FF; color: white">0x74</td> 
      <td style="background-color: #1E90FF; color: white">0xf9</td> 
      <td style="background-color: #1E90FF; color: white">0x8f</td> 
      <td style="background-color: #1E90FF; color: white">0x02</td> 
      <td style="background-color: #1E90FF; color: white">0x0c</td> 
      <td style="background-color: #1E90FF; color: white">0x83</td> 
      <td style="background-color: #1E90FF; color: white">0x6c</td> 
      <td style="background-color: #1E90FF; color: white">0x04</td> 
      <td style="background-color: #1E90FF; color: white">0x54</td> 
      <td style="background-color: #1E90FF; color: white">0x02</td> 
      <td style="background-color: red; color: white">0x55</td>
      <td style="background-color: red; color: white">0xAA</td>
   </tr>
</table>

##### Flags

<table>
   <tr>
      <td>Wert</td>
      <td>Beschreibung</td>
   </tr>
   <tr>
      <td>0x00</td>
      <td>Partition ist nicht bootfähig</td>
   </tr>
   <tr>
      <td>0x80</td>
      <td>bootfähige Partition</td>
   </tr>
</table>

##### CHS (Cylinder/Head/Sector)




##### CHS zu LBA umrechnen
> LBA: Logical Block Addressing<br/>

<img src="https://latex.codecogs.com/gif.latex?$LAB=(C&plus;H&plus;h)*S&plus;s-1" title="$LAB=(c+H+h)*S+s-1"/><br/>

| Variable | Beschreibung                                                         |
| :------: | :------------------------------------------------------------------- |
|    c     | Zylindernummer                                                       |
|    H     | Zahl der Leseköpfe                                                   |
|    h     | Lesekopfnummer                                                       |
|    S     | Zahl der Sektoren (= Zahö der Blöcke je Zylinderkopfspur  bzw. Tack) |
|    s     | Sektornummer                                                         |



Links: 
https://de.wikipedia.org/wiki/Master_Boot_Record<br/>
https://de.wikipedia.org/wiki/Cylinder_Head_Sector<br/>
https://de.wikipedia.org/wiki/Partitionstabelle<br/>
https://de.wikipedia.org/wiki/GUID_Partition_Table<br/>

