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
#### **Important:**
> The parameter `Id` must be within the range of the list length of chosen column fo all procedures.
---
## `AddElement(ElementText1: string; Id, Column: Integer):`
Adds a new element (`ElementText1`) at position `Id` in the chosen list (`Column`). The parameter `Id` must be within the range of the list length. The procedure displays the new element.

> * `ElementText1` (type: string) - the text of the element to be added.<br />
> * `Id` (type: Integer) - the position at which the element should be added.<br />
> * `Column` (type: Integer) - the column number in which the element should be added.<br />

**Example:**
```Delphi
  TListDisplay.AddElement('Test1', 0, 0); // adds 'Test1' to row 1 column 1 
  TListDisplay.AddElement('Test2', 0, 1); // adds 'Test2' to row 1 column 2 
```
---
- 
* `Delete(Id, Column: Integer):` Delete element of (`Id`) in chosen list (`Colum`n)<br />
* `Select(Id: Integer):` Change background color of Shapes in list of (`Id`) for both column, Scroll down if select is out of range maxRows<br />
* `Clear(Column: Integer):` Clears text lists selecelted (`Column`)<br />
* `Items(Id: Integer):string` Function thats export string of (`Id`) from FLabels2 (in future i add Column)<br />
* `Exchange(i, j, Column: Integer):` Exchanges item if Id (`i`) with item of Id (`j`) in chosen list (`Column`)<br />
* `Reverse(Column: Integer):` Reverse selected (`Column`)<br />
* `AssignStringsToColumn(ElementStrings: TStrings; Column: Integer):`Replace all selected (`Column`) witch selected (`ElementString`)<br />
  



