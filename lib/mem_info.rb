class MemInfo
  class NoProcData < Exception; end

  attr_accessor :memtotal, :memfree, :buffers, :cached, :swapcached, :active, :inactive,
                :active_anon, :inactive_anon, :active_file, :inactive_file, :unevictable,
                :mlocked, :swaptotal, :swapfree, :dirty, :writeback, :anonpages, :mapped,
                :slab, :sreclaimable, :sunreclaim, :pagetables, :nfs_unstable, :bounce,
                :writebacktmp, :commitlimit, :committed_as, :vmalloctotal, :vmallocused,
                :vmallochunk, :directmap4k, :directmap2m
  
  @@attributes = {
    :memtotal       => "MemTotal",
    :memfree        => "MemFree",
    :buffers        => "Buffers",
    :cached         => "Cached",
    :swapcached     => "SwapCached",
    :active         => "Active",
    :inactive       => "Inactive",
    :active_anon    => "Active\(anon\)",
    :inactive_anon  => "Inactive\(anon\)",
    :active_file    => "Active\(file\)",
    :inactive_file  => "Inactive\(file\)",
    :unevictable    => "Unevictable",
    :mlocked        => "Mlocked",
    :swaptotal      => "SwapTotal",
    :swapfree       => "SwapFree",
    :dirty          => "Dirty",
    :writeback      => "Writeback",
    :anonpages      => "AnonPages",
    :mapped         => "Mapped",
    :slab           => "Slab",
    :sreclaimable   => "SReclaimable",
    :sunreclaim     => "SUnreclaim",
    :pagetables     => "PageTables",
    :nfs_unstable   => "NFS_Unstable",
    :bounce         => "Bounce",
    :writebacktmp   => "WritebackTmp",
    :commitlimit    => "CommitLimit",
    :committed_as   => "Committed_AS",
    :vmalloctotal   => "VmallocTotal",
    :vmallocused    => "VmallocUsed",
    :vmallocchunk   => "VmallocChunk",
    :directmap4k    => "DirectMap4k",
    :directmap2m    => "DirectMap2M"
  }
  
  
  def initialize
    if File.exists?("/proc/meminfo")
      File.open("/proc/meminfo", "r") do |file|
        data = file.read
        @@attributes.keys.each do |attribute|
          instance_variable_set("@#{attribute.to_s}", regex_match(attribute, data).to_i)
        end
      end
    else
      raise NoProcData, "This system doesn't have /proc/meminfo data."
    end
  end
  
  def memused
    @memtotal - @memfree
  end

  def free_buffers
    @memfree + @buffers + @cached
  end
  
  private
    def regex_match(attribute, line)
      regex = Regexp.new("#{@@attributes[attribute]}:\\s*(.*?)\\s")
      regex.match(line)[1] if regex === line
    end
end
