import sys
import os 
import psutil
import memory_profiler
import torch
import numpy as np
import subprocess as sp
import time
import pdb


# constant
_kb = 1024;


# environment variables
_DOE_ROW = int(os.environ.get("_DOE_ROW"));
_DOE_COL = int(os.environ.get("_DOE_COL"));
_DOE_ITER = int(os.environ.get("_DOE_ITER"));


# current process information
p = psutil.Process()
print("### INF:  p.pid: ", p.pid);
with open('/tmp/.star.doe.main_exec.pid', 'w') as f:
    f.write(str(p.pid));
#sp.run(["konsole", "-e 'top -p $(cat /tmp/.star.doe.main_exec.pid)' &"]);
#time.sleep(1);
#sp.Popen(["konsole", "-e", "top", "-p", "$(cat /tmp/.star.doe.main_exec.pid)"]); ### it does not work
#sp.Popen(["konsole", "-e top -p $(cat /tmp/.star.doe.main_exec.pid)"]); ### it does not work
#sp.Popen(["konsole", "-e", "top"]); ### it does not work
sp.Popen(["konsole", "-e", "top", "-p", str(p.pid)]);
pdb.set_trace();


gmi = p.memory_info(); # global memory info
def print_mem_info_in_kb():
    #
    # current memory info
    m = p.memory_info();
    m_rss_kb = m.rss / _kb;
    m_vms_kb = m.vms / _kb;
    m_shared_kb = m.shared / _kb;
    m_text_kb = m.text / _kb;
    m_data_kb = m.data / _kb;
    m_lib_kb = m.lib / _kb;
    m_dirty_kb = m.dirty / _kb;
    #
    # global memory info (previous)
    global gmi;
    gmi_rss_kb = gmi.rss / _kb;
    gmi_vms_kb = gmi.vms / _kb;
    gmi_shared_kb = gmi.shared / _kb;
    gmi_text_kb = gmi.text / _kb;
    gmi_data_kb = gmi.data / _kb;
    gmi_lib_kb = gmi.lib / _kb;
    gmi_dirty_kb = gmi.dirty / _kb;
    #
    print("____________________________________________________________________");
    print("     (unit) item:     current  (=  previous  +  delta  )            ");
    print("____________________________________________________________________");
    print("     (KB) vms:       ", m_vms_kb, " (= ", gmi_vms_kb, " + ", m_vms_kb - gmi_vms_kb, " )");
    print("     (KB) shared:    ", m_shared_kb, " (= ", gmi_shared_kb, " + ", m_shared_kb - gmi_shared_kb, " )");
    print("     (KB) text:      ", m_text_kb, " (= ", gmi_text_kb, " + ", m_text_kb - gmi_text_kb, " )");
    print("     (KB) data:      ", m_data_kb, " (= ", gmi_data_kb, " + ", m_data_kb - gmi_data_kb, " )");
    print("     (KB) rss:       ", m_rss_kb, " (= ", gmi_rss_kb, " + ", m_rss_kb - gmi_rss_kb, " )");
    print("     (KB) lib:       ", m_lib_kb, " (= ", gmi_lib_kb, " + ", m_lib_kb - gmi_lib_kb, " )");
    print("     (KB) dirty:     ", m_dirty_kb, " (= ", gmi_dirty_kb, " + ", m_dirty_kb - gmi_dirty_kb, " )");
    print("____________________________________________________________________");
    #
    gmi = m;
    return m;
    

@memory_profiler.profile
def numpy_mat_amplify(r,c,n):
    mat_a = torch.randn(r,c);
    mat_c = torch.randn(r,c);
    print_mem_info_in_kb();
    for i in range(1,n+1):
        print("numpy_mat_amplify(", i, ")", mat_c.shape);
        mat_c = torch.cat((mat_c, mat_a), 0);
    print_mem_info_in_kb();

@memory_profiler.profile
def numpy_mat_concat(r,c):
    mat_a = np.zeros((r,c));
    mat_b = np.zeros((r, c));
    mat_c = np.concatenate(mat_a, mat_b);
    print("mat_a.nbytes", mat_a.nbytes);
    print("mat_b.nbytes", mat_b.nbytes);
    print("mat_c.nbytes", mat_c.nbytes);
    del mat_a;
    del mat_b;
    del mat_c;

@memory_profiler.profile
def torch_mat_mul(r,c):
    mat_a = torch.Tensor(r, c)
    print("mat_a.nbytes", mat_a.nbytes);
    mat_b = torch.Tensor(r, c)
    print("mat_b.nbytes", mat_b.nbytes);
    mat_c = mat_a * mat_b.t()
    print("mat_c.nbytes", mat_c.nbytes);
    del mat_a;
    del mat_b;
    del mat_c;


m1 = print_mem_info_in_kb();
numpy_mat_amplify(_DOE_ROW, _DOE_COL, _DOE_ITER);
m2 = print_mem_info_in_kb();


diff_rss = m2.rss - m1.rss;
diff_vms = m2.vms - m1.vms;
diff_shared = m2.shared - m1.shared;
diff_text = m2.text - m1.text;
diff_lib = m2.lib - m1.lib;
diff_data = m2.data - m1.data;
diff_dirty = m2.dirty - m1.dirty;


print("----------");
print("m2 - m1:\n");
print("     (KB) vms: ", diff_vms/_kb);
print("     (KB) shared: ", diff_shared/_kb);
print("     (KB) text: ", diff_text/_kb);
print("     (KB) data: ", diff_data/_kb);
print("     (KB) rss: ", diff_rss/_kb);
print("     (KB) lib: ", diff_lib/_kb);
print("     (KB) dirty: ", diff_dirty/_kb);
print("----------");
# rss, vms, shared, text, lib, data, dirty
# diff_rss, diff_vms, diff_shared, diff_text, diff_lib, diff_data, diff_dirty
