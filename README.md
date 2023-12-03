# TListDisplay
Custom component for Delphi. This is two list combine in one object without user mouse inputs.

## usage:

### **Consts:**<br />
* `FShapes1:` List of background shapes (Background cells) of column 1<br />
* `FShapes2:` List of background shapes (Background cells) of column 2<br />
* `FLabels1:` List of text elements of column 1<br />
* `FLabels2:` List of text elements of column 2<br />
* `MyIni:` Ini file for save data for example position<br />

### **Procedures:**<br />
* `AddElement(ElementText1: string; Id, Column: Integer):` Adds element (`ElementText1`) on Id in chosen list (`Column`), (Id must be in range of list Length) and displays new item<br />
* `Delete(Id, Column: Integer):` Delete element of (`Id`) in chosen list (`Colum`n)<br />
* `Select(Id: Integer):` Change background color of Shapes in list of (`Id`) for both column, Scroll down if select is out of range maxRows<br />
* `Clear(Column: Integer):` Clears text lists selecelted (`Column`)<br />
* `Items(Id: Integer):string` Function thats export string of (`Id`) from FLabels2 (in future i add Column)<br />
* `Exchange(i, j, Column: Integer):` Exchanges item if Id (`i`) with item of Id (`j`) in chosen list (`Column`)<br />
* `Reverse(Column: Integer):` Reverse selected (`Column`)<br />
* `AssignStringsToColumn(ElementStrings: TStrings; Column: Integer):`Replace all selected (`Column`) witch selected (`ElementString`)<br />
  



