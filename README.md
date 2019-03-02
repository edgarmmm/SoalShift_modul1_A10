
# Soal Shift Modul 1 A10
1. Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.
Hint: Base64, Hexdump

    ### Jawaban:

* Source Code: [disini](/soal1.sh)
* Langkah - langkah:
	1. Buat Script bash untuk mendecrypt isi file nature.zip 
	2. File tersebut diunzip menggungakan `unzip`
	3. Lalu di decrypt menggunakan `base64 -d`
	4. Setelah itu reverse hexdump filenya dengan `xxd -r`
	5. Lalu buat cron job dengan mengetikan perintah `crontab -e` dan atur waktu sesuai perintah soal

      14 14 * 2 5 /bin/bash /home/gede/soal1.sh
      14 14 14 2 * /bin/bash /home/gede/soal1.sh

2. Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta
untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv.
Laporan yang diminta berupa:

    a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.

    b. Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a.

    c. Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.

    ### Jawaban: 
* Source code: [disini](/soal2.sh)
* Langkah - langkah
      
     a. Buat awk script seperti dibawah ini
     ``` bash
	awk -F "," '{if ($7 == 2012) i[$1]+=$10} END {for (x in i) if(max<i[x]) {max=i[x]; country=x} print max, country}' /home/gede/modul1/WA_Sales_Products_2012-14.csv
     ```
	#### Keterangan
	* `if ($7 == 2012) i[$1]+=$10` untuk menghitung jumlah quantity setiap negara
	* `for (x in i) if(max<i[x]) {max=i[x]; country=x}` mencari quantity terbanyak
	* `print max, country` print negara dengan quantity terbanyak

      b. Buat awk script seperti dibawah ini
     ```bash
	awk -F "," '{if ($1 == "United States" && $7 == 2012) j[$4]+=$10} END {for (x in j) {print j[x], x}}' /home/gede/modul1/WA_Sales_Products_2012-14.csv | sort -nr | head -n 3 | awk '{print $2" "$3}'
     ```
	#### Keterangan
	* `if ($1 == "United States" && $7 == 2012) j[$4]+=$10` untuk menghitung quantity di setiap product line
	* `sort -nr` untuk mensort dari terbesar ke terkecil
	* `head -n 3` untuk mengambil 3 terbesar
	* `awk '{print $2" "$3}'` untuk print 3 product line terbanyak

      c. Buat awk script seperti dibawah ini
     ```bash
	awk -F "," '{if ($1 == "United States" && $7 == 2012 && ($4 == "Personal Accessories" || $4 == "Camping Equipment" || $4 == "Outdoor Protection")) k[$6]+=$10} END {for (x in k) {print k[x], x}}' /home/gede/modul1/WA_Sales_Products_2012-14.csv | sort -nr | head -n 3 | awk '{print $2" "$3}'
     ```
	* `if ($1 == "United States" && $7 == 2012 && ($4 == "Personal Accessories" || $4 == "Camping Equipment" || $4 == "Outdoor Protection"` untuk menghitung quantity dari product
	*  `sort -nr` untuk mensort dari terbesar ke terkecil
	* `head -n 3` untuk mengambil 3 terbesar
	* `awk '{print $2" "$3}'` untuk print 3 product terbanyak

3. Buatlah sebuah script bash yang dapat menghasilkan password secara acak
sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password
acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama
sebagai berikut:

    a. Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt
    
    b. Jika file password1.txt sudah ada maka password acak baru akan disimpan pada file bernama password2.txt dan begitu seterusnya.

    c. Urutan nama file tidak boleh ada yang terlewatkan meski filenya dihapus.

    d. Password yang dihasilkan tidak boleh sama.
    
    ### Jawaban:
* Source code: [disini](/soal3.sh)
* Langkah - langkah:
	 1. Buat script bash terlebih dahulu
	 2. Buat array berisi password yang telah disimpan di password1 dst
	 3. Cek apakah file password1.txt sudah dibuat, bila sudah ada, buat password2.txt. Bila masih ada lakukan terus hingga file password ke n belum dibuat
	 4. setelah itu buat generate random passwordnya
	 5. Lalu cek apakah password baru tersebut sudah ada, dengan mengecek array yang di langkah ii
	 6. Jika ada di array ada generate lagi passwordnya dst sampai password tersebut tidak ada di array tersebut
	 7. Setelah tidak ada simpan password tersebut di file yg sudah dibuat di langkah iii
	 
4. Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal- bulan-tahun”. 
Isi dari file backup terenkripsi dengan konversi huruf (string manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai berikut:

    a. Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki urutan ke 12+2 = 14.

    b. Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke empat belas, dan seterusnya.

    c. setelah huruf z akan kembali ke huruf a

    d. Backup file syslog setiap jam.

    e. dan buatkan juga bash script untuk dekripsinya.

    ### Jawaban:
* Source code: [disini](/soal4.sh) dan [disini](/soal4_decrypt.sh)
* Langkah - langkah:
	1. Untuk Encrypt
		* Buat script bash encrypt terlebih dahulu
		* Extract jam dari `date` untuk membuat key dari enkripsi tersebut
		* Extract jam:menit tanggal-bulan-tahun dari `date` untuk membuat nama file
		* Lalu encrypt file syslog tersebut dengan key dari langkah 2
		* Setelah itu simpan file encrypt tersebut dengan format yang telah dibuat di langkah 3
		* Jangan lupa buat cron jobnya sesuai soal seperti dibawah ini
		
		  `0 */1 * * * /bin/bash /home/gede/soal4.sh`
	2. Untuk Decrypt
		* Buat script bash Decrypt terlebih dahulu
		* Simpan nama file yg sudah dienkripsi sebelumnya
		* Extract keynya dari nama file yang sudah di encrypt
		* Lalu decrypt file tersebut dengan key yang ada di langkah iii
		* Setelah itu simpan file encrypt tersebut dengan nama file yang telah disimpan di langkah ii
		
5. Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi
kriteria berikut:

    a. Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.

    b. Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.

    c. Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.

    d. Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.
    
    ### Jawaban:
* Source code: [disini](/soal5.sh)
* Langkah - langkah:
	1. Buat script awk terlebih dahulu
	2. Buat script awk seperti dibawah ini
	```bash
	awk '{if($0 ~ /cron/ && $0 !~ /sudo/ && NF < 13) print $0}' /var/log/syslog > /home/gede/modul1/soal5.log
	```
	#### Keterangan
	* `if($0 ~ /cron/ && $0 !~ /sudo/ && NF < 13)` untuk menyeleksi file tersebut mengandung string **cron** dan tidak mengandung string **sudo** lalu jumlah field dari file tersebut haru berjumlah kurang dari 13
	
	3. Setelah itu disimpan di /home/\<user>/modul1
	4. Tidak lupa juga buat cron jobnya sesuai soal seperti dibawah ini
	
	`2-30/6 * * * * /bin/bash /home/gede/soal5.sh`
