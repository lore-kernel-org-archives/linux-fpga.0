Return-Path: <SRS0=fEzc=Z6=gmail.com=delicious.quinoa@kernel.org>
Return-Path: <SRS0=fEzc=Z6=gmail.com=delicious.quinoa@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAtXAHdbE0Rjodqayi4pNTTT6jnVT6hwHJ_3z8Y2uUgz-Ywayg@mail.gmail.com>
References: <1487175261-7051-1-git-send-email-atull@kernel.org>
 <1487175261-7051-5-git-send-email-atull@kernel.org> <CAAtXAHdbE0Rjodqayi4pNTTT6jnVT6hwHJ_3z8Y2uUgz-Ywayg@mail.gmail.com>
From: Alan Tull <delicious.quinoa@gmail.com>
Date: Fri, 17 Feb 2017 16:02:20 -0600
Message-ID: <CANk1AXTVmHRpffGz-1T3G5uQO21qiyepWaCQhnfe8FCPCf93pA@mail.gmail.com>
Subject: Re: [RFC 4/8] doc: fpga-mgr: separate getting/locking FPGA manager
Content-Type: text/plain; charset=UTF-8
To: Moritz Fischer <mdf@kernel.org>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Feb 17, 2017 at 11:52 AM, Moritz Fischer <mdf@kernel.org> wrote:
> Alan,
>
> small nits inline

Hi Moritz,

Thanks for the review!

Alan

>
> On Wed, Feb 15, 2017 at 8:14 AM, Alan Tull <atull@kernel.org> wrote:
>> Document that getting a reference to a FPGA Manager has been
>> separated from locking the FPGA Mangager for use.
>>
>> fpga_mgr_lock/unlock functions get/release mutex.
>>
>> of_fpga_mgr_get, fpga_mgr_get, and fpga_mgr_put no longer lock
>> the FPGA manager mutex.
>>
>> This makes it more straigtforward to save a reference to
>> a FPGA manager and only attempting to lock it when programming
>> the FPGA.
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>
>
>> ---
>>  Documentation/fpga/fpga-mgr.txt | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/fpga/fpga-mgr.txt b/Documentation/fpga/fpga-mgr.txt
>> index 78f197f..06d5d5b 100644
>> --- a/Documentation/fpga/fpga-mgr.txt
>> +++ b/Documentation/fpga/fpga-mgr.txt
>> @@ -53,13 +53,26 @@ To get/put a reference to a FPGA manager:
>>         struct fpga_manager *of_fpga_mgr_get(struct device_node *node);
>>         struct fpga_manager *fpga_mgr_get(struct device *dev);
>>
>> -Given a DT node or device, get an exclusive reference to a FPGA manager.
>> +Given a DT node or device, get an reference to a FPGA manager.  Pointer
>
> Nits: get *a* reference, 'A' pointer or 'The' pointer.
>
>> +can be saved until you are ready to program the FPGA.
>>
>>         void fpga_mgr_put(struct fpga_manager *mgr);
>>
>>  Release the reference.
>>
>>
>> +To get exclusive control of a FPGA manager:
>> +-------------------------------------------
>> +
>> +       int fpga_mgr_lock(struct fpga_magager *mgr);
>> +
>> +Call fpga_mgr_lock and verify that it returns 0 before attempting to
>> +program the FPGA.
>> +
>> +       void fpga_mgr_unlock(struct fpga_magager *mgr);
>> +
>> +Call fpga_mgr_unlock when done programming the FPGA.
>> +
>>  To register or unregister the low level FPGA-specific driver:
>>  -------------------------------------------------------------
>>
>> @@ -95,11 +108,13 @@ int ret;
>>
>>  /* Get exclusive control of FPGA manager */
>>  struct fpga_manager *mgr = of_fpga_mgr_get(mgr_node);
>> +ret = fpga_mgr_lock(mgr);
>>
>>  /* Load the buffer to the FPGA */
>>  ret = fpga_mgr_buf_load(mgr, &info, buf, count);
>>
>>  /* Release the FPGA manager */
>> +fpga_mgr_unlock(mgr);
>>  fpga_mgr_put(mgr);
>>
>>
>> @@ -124,11 +139,13 @@ int ret;
>>
>>  /* Get exclusive control of FPGA manager */
>>  struct fpga_manager *mgr = of_fpga_mgr_get(mgr_node);
>> +ret = fpga_mgr_lock(mgr);
>>
>>  /* Get the firmware image (path) and load it to the FPGA */
>>  ret = fpga_mgr_firmware_load(mgr, &info, path);
>>
>>  /* Release the FPGA manager */
>> +fpga_mgr_unlock(mgr);
>>  fpga_mgr_put(mgr);
>>
>>
>> --
>> 2.7.4
>>
>
> Cheers,
>
> Moritz
