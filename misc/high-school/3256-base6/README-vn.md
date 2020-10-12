## 2020/10/12 (月)
Tối hôm qua Na hỏi tôi một bài toán học; Na đang học lớp 11, cái bài này là như thế này
> Nếu chúng ta chỉ được phép sử dụng 6 chữ số từ tập $\{1,2,3,4,5,6\}$, thì có thể tạo ra bao nhiêu con số gồm 4 chữ số (chữ số được phép lặp lại) nhỏ hơn $3256$ (i.e. $< 3256$)?

Cái bài này không có khó, nhưng mà tôi vẫn muốn viết xuống lưu lại.


### Ý tưởng 01: `base6`
Thay vì suy nghĩ bằng `base10` rồi nói rằng số $1999$ không thỏa mãn điều kiện và số $1666$ thì được, chúng ta sẽ
suy nghĩ bằng `base6`, tức là chỉ sử dụng $6$ con số là $\{0,1,2,3,4,5\}$.

Trong bài toán góc, con số nhỏ nhất và phù hợp là $1111$; con số tương ứng số này trong `base6` sẽ là $(0000)_6$
<br>
Con số ngững $3256$ chúng ta cũng nên phiên dịch nó thành $(2145)_6$ (i.e. con số nào cũng phải xuống $1$ như ở trên)

**N.B.** Ý của chúng ta
- <b>không phải</b>  $(3256)_{10} = (2145)_6$
- mà là trong bài toán góc chúng ta chỉ được phép 6 chữ số là $\{1,2,3,4,5,6\}$, việc này <b>không khác gì</b> khi chúng ta chỉ được phép sử dụng 6 chữ số $\{0,1,2,3,4,5\}$và tìm con số nhỏ hơn $(2145)_6$.

Một khi chuyển qua hệ thổng `base6` như vậy chúng ta có thể nhận ra rằng số lượng con số nhỏ hơn $(2145)_6$ sẽ là những con số từ $(0000)_6$ đến $(2144)_6$, có
> $2\cdot6^3 + 1\cdot6^2 + 4\cdot6^1 + 5\cdot6^0 = 497$ số.


**Rmk.** Nếu bạn đọc không hiểu cái gì là `base6` hoặc `base10`, thì có thể tạm bỏ qua phần này; hoặc là tôi sẽ đăng thêm một bài viết về nó vào thời điểm sau. Thật ra, tụi nó cũng khá đơn giản:
- $(2145)_6 = 2\cdot6^3 + 1\cdot6^2 + 4\cdot6^1 + 5\cdot6^0$
- $(3256)_{10} = 3\cdot{10}^3 + 2\cdot{10}^2 + 5\cdot{10}^1 + 6\cdot{10}^0$


### Ý tưởng 02
Tôi đoán ý tưởng này chính là những gì được dạy ở lớp 11.
- Nếu con số đầu tiên, tức là **con số bên tay trái nhất**, chúng ta chọn $1$ hoặc là $2$, thì ba con số phía sau chọn $6$ con số nào trong $\{1,2,3,4,5,6\}$ cũng được. Vì vậy chúng ta đã tìm ra $2\cdot6^3$ con số phù hợp.
- Nhắc lại ngững của chúng ta là $3256$. Giờ chúng ta suy xét trường hợp con số đầu tiên đã được chọn là $3$. Nếu con số thứ hai được chọn là $1$ (i.e. nhỏ hơn $2$, con số thứ hai của $3256$), thì, như ở trên, sẽ có $1 \cdot 6^2$ con số phù hợp.
- Cứ suy nghĩ theo lối này, chúng ta sẽ tìm thấy tổng con số phù hợp là $$2\cdot6^3 + 1\cdot6^2 + 4\cdot6^1 + 5\cdot6^0 = 497$$ y như trong ý tưởng đầu tiên.


### Code
Chúng ta có thể dễ dàng viết code tìm ra tất cả mỗi con số phù hợp và số lượng của những con số này.
<br>
Ở đây chúng ta sẽ chọn <b>Pascal</b> và <b>Python</b> vì lớp 11 vào năm 2020 có khá năng sử dung hai ngôn ngữ này nhất.

Vì bài đã khá dài, nên tôi sẽ không tốn thêm thời gian giải thích code nữa (với thật ra code cũng tương đối đơn giản).

- Tôi viết hai cái Python scripts <code><b>str.py</b></code> va <code><b>int.py</b></code>, bản chất hai cái y như nhau, chỉ khác ở cách code.
    - Cách chạy hai scripts này là, e.g. (trên terminal) <code><b>$ python str.py</b></code>
      ```bash
      [phunc20@denjiro-x220 3256-base6]$ python str.py
      There are 497 such integers.
      ```
    - Which script is faster?
      ```bash
      [phunc20@denjiro-x220 3256-base6]$ time python str.py
      There are 497 such integers.
      
      real    0m0.037s
      user    0m0.028s
      sys     0m0.008s
      [phunc20@denjiro-x220 3256-base6]$ time python str.py
      There are 497 such integers.
      
      real    0m0.037s
      user    0m0.026s
      sys     0m0.011s
      ```
- Vì Pascal tôi không rành nên chỉ viết một cái là <code><b>int.lpr</b></code>
    - Cách chạy Pascal hơi khác
    - Hình như đầu tiên cần <b>compile <code>.lpr</code> file</b> bằng cách chạy lệnh trên terminal là <code><b>$ fpc int.lpr</b></code>
    - <code><b>fpc</b></code> là Free Pascal Complier và nếu bạn đọc sử dụng Linux thì có thể dễ dàng instal bằng bất cứ package manager nào, e.g.
        - trên Arch Linux qua lệnh <code><b>sudo pacman -S fpc</b></code>
        - trên Ubuntu qua lệnh <code><b>sudo apt install fpc</b></code> hoặc <code><b>sudo apt-get install fpc</b></code>
    - Bước compile ở trên sẽ tạo ra <b>executable</b> măng tên <code><b>int</b></code>; bước còn lại chỉ việc gỗ lệnh <code><b>$ ./int</b></code> là xong.


### Further Thinking
- Compare the speed of the scripts <code>int.py</code> and <code>str.py</code>
- No matter which one of <code>str.py</code> and <code>int.py</code> is faster, try to explain why.
