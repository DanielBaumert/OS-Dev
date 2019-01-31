# OS-Dev

## Bootloader
### System start

- Bios:
  1. such nach dem Bootloader/Bootmanager auf dem "Master Boot Record" (MBR)
 
### Master Boot Record
 - Enthält das Startprogramm und die Partitionstabelle
 - Liegt im Track 0 Side 0 Sector 0
 - Am ende muss 0x55AA stehe
Der Speicheraufbaue der MBR ist wie folgt 

| Stage 1 Bootloader | Master Partition Enty 0 | Master Partition Enty 1 | Master Partition Enty n | Magic number |
| ------------------ | ----------------------- | ----------------------- | ----------------------- | ------------ |
<br/>
<table border="0">
 <tr>
    <td colspan="2"><b>Addr.</b>
    <td rowspan="2" colspan="2"><b>Function/Inhalt</b></td>
    <td rowspan="2"><b>Size(Byte)</b></td>
 </tr>
 <tr>
    <td>Hex</td>
    <td>Dez</td>
 </tr>
 <tr>
    <td>0x0000</td>
    <td>0</td>
    <td colspan="2">Startprogamm(bootloader)</td>
    <td>440</td>
 </tr>
 <tr>
    <td>0x01B8</td>
    <td>440</td>
    <td colspan="2">Datenträger Signatur</td>
    <td>4</td>
 </tr>
 <tr>
    <td>0x01BC</td>
    <td>444</td>
    <td colspan="2">Null (0x0000)</td>
    <td>2</td>
 </tr> 
 <tr>
    <td>0x01BE</td>
    <td>446</td>
    <td colspan="2">Partitionstabelle</td>
    <td>64</td>
 </tr>
 <tr>
    <td>0x01FE</td>
    <td>510</td>
    <td>55<sub>hex</sub>
    <td rowspan="2">Bootsektor-Signatur</td>
    <td rowspan="2">2</td>
 </tr>
 <tr >
    <td>0x01FE</td>
    <td>511</td>
    <td>AA<sub>hex</sub>
 </tr>
 <tr>
  <td colspan="4">Gesammt:</td>
  <td>512</td>
</table>

### Partitions Tabelle 
| Flag  | Start CHS | Type  | End CHS | Start LBA | Size  |
| :---: | :-------: | :---: | :-----: | :-------: | :---: |
| 1Byte |   3Byte   | 1Byte |  3Byte  |   4Byte   | 4Byte |

> CHS: Cylinder/Head/Sector<br/>
> LBA: Logical Block Addressing<br/>
### CHS (Cylinder/Head/Sector)

### LBA 
<img src="https://latex.codecogs.com/gif.latex?$LAB=(C&plus;H&plus;h)*S&plus;s-1" title="$LAB=(c+H+h)*S+s-1"/><br/>

| Variable | Beschreibung                                                         |
| :------: | :------------------------------------------------------------------- |
|    c     | Zylindernummer                                                       |
|    H     | Zahl der Leseköpfe                                                   |
|    h     | Lesekopfnummer                                                       |
|    S     | Zahl der Sektoren (= Zahö der Blöcke je Zylinderkopfspur  bzw. Tack) |
|    s     | Sektornummer                                                         |
